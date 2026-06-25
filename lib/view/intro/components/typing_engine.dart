import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'painters/subtle_dot_grid_painter.dart';
import 'painters/cyber_orbit_painter.dart';
import 'widgets/typing_overlays.dart';
import 'utils/typing_audio_mixin.dart';
import 'widgets/typing_terminal_card.dart';
import 'widgets/typing_badges.dart';
import 'widgets/typing_lines_renderer.dart';

import 'mixins/typing_logic_mixin.dart';

class TypingEngine extends StatefulWidget {
  const TypingEngine({super.key});

  @override
  State<TypingEngine> createState() => _TypingEngineState();
}

class _TypingEngineState extends State<TypingEngine>
    with TypingAudioMixin, TypingLogicMixin {
  @override
  void initState() {
    super.initState();
    initTypingLogic();
  }

  @override
  void dispose() {
    disposeTypingLogic();
    super.dispose();
  }

  @override
  void playTypingSoundFromMixin() {
    playTypingSound();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      autofocus: false,
      onKeyEvent: (node, event) {
        final isModifierPressed = HardwareKeyboard.instance.isControlPressed ||
            HardwareKeyboard.instance.isAltPressed ||
            HardwareKeyboard.instance.isMetaPressed;

        if (isModifierPressed) {
          if (HardwareKeyboard.instance.isControlPressed &&
              event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.keyR) {
            resetTyping();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        }

        if (completed) return KeyEventResult.ignored;

        if (event is KeyDownEvent && focusNode.hasFocus) {
          handleKeyEvent(event);
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            focusNode.requestFocus();
            setState(() {});
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double engineWidth =
                  constraints.maxWidth.clamp(260.0, 500.0);
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -45,
                    right: -45,
                    child: IgnorePointer(
                      child: SizedBox(
                        width: 320,
                        height: 320,
                        child: RepaintBoundary(
                          child:
                              CustomPaint(painter: const CyberOrbitPainter()),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: engineWidth,
                    child: TypingTerminalCard(
                      hasFocus: focusNode.hasFocus,
                      child: Column(
                        children: [
                          const TypingTitleBar(),
                          Expanded(
                            child: RepaintBoundary(
                              child: Stack(
                                children: [
                                  const Positioned.fill(
                                    child: CustomPaint(
                                        painter: SubtleDotGridPainter()),
                                  ),
                                  ValueListenableBuilder<int>(
                                    valueListenable: typingTick,
                                    builder: (context, _, _) {
                                      return TypingBadges(
                                        row: row,
                                        col: col,
                                        completed: completed,
                                      );
                                    },
                                  ),
                                  Positioned.fill(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 24, right: 24, top: 56),
                                      child: ValueListenableBuilder<int>(
                                        valueListenable: typingTick,
                                        builder: (context, _, _) {
                                          return TypingLinesRenderer(
                                            targetLines: targetLines,
                                            inputLines: inputLines,
                                            row: row,
                                            col: col,
                                            cachedSyntaxColors:
                                                cachedSyntaxColors,
                                            isStarted: startTime != null,
                                            showCursor: cursorVisible.value,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  ValueListenableBuilder<int>(
                                    valueListenable: typingTick,
                                    builder: (context, _, _) {
                                      if (showLeaderboard) {
                                        return TypingLeaderboardOverlay(
                                          finalWps: finalWps,
                                          onReset: resetTyping,
                                          initialIsScoreSaved: isScoreSaved,
                                          onScoreSaved: (saved) => setState(
                                              () => isScoreSaved = saved),
                                        );
                                      }
                                      return Positioned(
                                        bottom: 10,
                                        right: 16,
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: resetTyping,
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withValues(alpha: 0.05),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.white10),
                                              ),
                                              child: const Icon(
                                                Icons.refresh,
                                                color: Colors.white38,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ).animate().fadeIn(delay: 500.ms),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          RepaintBoundary(
                            child: ValueListenableBuilder<int>(
                              valueListenable: typingTick,
                              builder: (context, _, _) => TypingStatsBar(
                                startTime: startTime,
                                wps: wps,
                                accuracy: accuracy,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.95, 0.95));
  }
}
