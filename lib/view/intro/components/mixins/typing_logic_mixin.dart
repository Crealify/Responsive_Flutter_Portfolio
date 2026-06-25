import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../view_model/getx_controllers/portfolio_controller.dart';
import '../utils/typing_syntax_highlighter.dart';

mixin TypingLogicMixin<T extends StatefulWidget> on State<T> {
  final String target = '''class Engineer {
  name = "Anil Bhattarai";
  skills = ["Flutter", "Dart"];
  build ()=> "Apps";
}''';

  late List<String> inputLines;
  late List<List<Color>> cachedSyntaxColors;
  int row = 0;
  int col = 0;
  DateTime? startTime;
  bool completed = false;
  bool showLeaderboard = false;
  final ValueNotifier<bool> cursorVisible = ValueNotifier(true);
  late Timer cursorTimer;
  final FocusNode focusNode = FocusNode();
  bool isScoreSaved = false;
  int finalWps = 0;
  
  final ValueNotifier<int> typingTick = ValueNotifier<int>(0);

  void updateTypingState(VoidCallback fn) {
    fn();
    typingTick.value++;
  }

  void initTypingLogic() {
    inputLines = List.generate(target.split('\n').length, (_) => "");
    cachedSyntaxColors = target.split('\n').map((line) => TypingSyntaxHighlighter.tokenizeLine(line)).toList();
    cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!completed) {
        cursorVisible.value = !cursorVisible.value;
        typingTick.value++;
      }
    });
  }

  void disposeTypingLogic() {
    cursorTimer.cancel();
    focusNode.dispose();
    cursorVisible.dispose();
    typingTick.dispose();
  }

  List<String> get targetLines => target.split('\n');
  int get safeRow => row.clamp(0, targetLines.length - 1);

  int get wps {
    if (completed) return finalWps;
    if (startTime == null) return 0;
    final sec = DateTime.now().difference(startTime!).inSeconds;
    if (sec <= 0) return 0;
    final characters = inputLines.join("").length;
    final words = characters / 5;
    return (words / sec * 60).toInt();
  }

  double get accuracy {
    String input = inputLines.join("\n");
    if (input.isEmpty) return 0;
    int correct = 0;
    for (int i = 0; i < input.length && i < target.length; i++) {
      if (input[i] == target[i]) correct++;
    }
    return (correct / input.length) * 100;
  }

  void checkComplete() {
    if (inputLines.join("\n") == target) {
      finalWps = wps;
      updateTypingState(() {
        completed = true;
        showLeaderboard = true;
        isScoreSaved = false;
      });
    }
  }

  void playTypingSoundFromMixin(); // To be implemented by the class mixing this in

  void handleKeyEvent(KeyEvent event) {
    if (completed) return;
    if (startTime == null) {
      startTime = DateTime.now();
      Get.find<PortfolioController>().trackAction('typing_test_start');
    }

    if (event is KeyDownEvent) {
      final key = event.logicalKey;
      String tLine = targetLines[safeRow];

      if (key == LogicalKeyboardKey.enter) {
        if (row < targetLines.length - 1) {
          playTypingSoundFromMixin();
          updateTypingState(() {
            row++;
            String nextLineTarget = targetLines[row];
            int leadingSpaces = 0;
            while (leadingSpaces < nextLineTarget.length && nextLineTarget[leadingSpaces] == ' ') {
              leadingSpaces++;
            }
            col = leadingSpaces;
            inputLines[row] = " " * leadingSpaces;
          });
        }
        return;
      }

      if (key == LogicalKeyboardKey.backspace) {
        playTypingSoundFromMixin();
        updateTypingState(() {
          String tLineForCurrentRow = targetLines[safeRow];
          int leadingSpaces = 0;
          while (leadingSpaces < tLineForCurrentRow.length && tLineForCurrentRow[leadingSpaces] == ' ') {
            leadingSpaces++;
          }

          if (col > leadingSpaces) {
            String line = inputLines[safeRow];
            line = line.substring(0, col - 1) + line.substring(col);
            inputLines[safeRow] = line;
            col--;
          } else if (row > 0) {
            row--;
            col = inputLines[safeRow].length;
          }
        });
        return;
      }

      if (event.character != null && event.character!.isNotEmpty) {
        playTypingSoundFromMixin();
        String line = inputLines[safeRow];
        if (col >= tLine.length) {
          if (row < targetLines.length - 1) {
            updateTypingState(() {
              row++;
              String nextLineTarget = targetLines[row];
              int leadingSpaces = 0;
              while (leadingSpaces < nextLineTarget.length && nextLineTarget[leadingSpaces] == ' ') {
                leadingSpaces++;
              }
              col = leadingSpaces;
              inputLines[row] = " " * leadingSpaces;
            });
            line = inputLines[safeRow];
          } else {
            return;
          }
        }

        if (col == line.length) {
          line += event.character!;
        } else {
          line = line.substring(0, col) + event.character! + line.substring(col);
        }

        updateTypingState(() {
          inputLines[safeRow] = line;
          col++;
        });
        checkComplete();
      }
    }
  }

  void resetTyping() {
    updateTypingState(() {
      row = 0;
      col = 0;
      inputLines = List.generate(targetLines.length, (_) => "");
      completed = false;
      showLeaderboard = false;
      startTime = null;
      isScoreSaved = false;
      finalWps = 0;
    });
  }
}
