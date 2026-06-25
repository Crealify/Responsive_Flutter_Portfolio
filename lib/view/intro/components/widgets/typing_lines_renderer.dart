import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypingLinesRenderer extends StatelessWidget {
  final List<String> targetLines;
  final List<String> inputLines;
  final int row;
  final int col;
  final List<List<Color>> cachedSyntaxColors;
  final bool isStarted;
  final bool showCursor;

  const TypingLinesRenderer({
    super.key,
    required this.targetLines,
    required this.inputLines,
    required this.row,
    required this.col,
    required this.cachedSyntaxColors,
    required this.isStarted,
    required this.showCursor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildLines(),
    );
  }

  List<Widget> _buildLines() {
    List<Widget> widgets = [];
    for (int r = 0; r < targetLines.length; r++) {
      String tLine = targetLines[r];
      String iLine = inputLines[r];
      bool isCurrentRow = r == row;
      List<Color> syntaxColors = cachedSyntaxColors[r];
      List<InlineSpan> spans = [];

      for (int c = 0; c < tLine.length; c++) {
        bool typed = c < iLine.length;
        bool isCursorPos = r == row && c == col;

        Color syntaxColor = syntaxColors[c];
        Color color;
        Color? bgColor;
        List<Shadow>? textShadows;

        if (typed) {
          if (iLine[c] == tLine[c]) {
            color = syntaxColor;
            // Removed textShadows to fix massive input lag on Flutter Web
          } else {
            color = const Color(0xFFEF4444); // Premium vibrant red for errors
            bgColor = const Color(0xFFEF4444)
                .withValues(alpha: 0.2); // Light red highlight
          }
        } else {
          // Untyped text: 75% visible before typing starts, and 35% visible after typing starts to make active input pop!
          color = syntaxColor.withValues(
            alpha: !isStarted ? 0.75 : 0.35,
          );
        }

        final textStyle = GoogleFonts.firaCode(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.1,
          color: color,
          backgroundColor: bgColor,
          shadows: textShadows,
        );

        if (isCursorPos) {
          spans.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                decoration: showCursor
                    ? BoxDecoration(
                        color: const Color(
                            0xFFEAB308), // Solid yellow block cursor
                        borderRadius: BorderRadius.circular(2),
                      )
                    : (bgColor != null ? BoxDecoration(color: bgColor) : null),
                child: Text(
                  tLine[c],
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                    color: showCursor ? const Color(0xFF1E1E1E) : color,
                    shadows: showCursor ? null : textShadows,
                  ),
                ),
              ),
            ),
          );
        } else {
          spans.add(TextSpan(text: tLine[c], style: textStyle));
        }
      }
      widgets.add(Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isCurrentRow
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Text(
                "${r + 1}",
                style: GoogleFonts.firaCode(
                  color: isCurrentRow
                      ? const Color(0xFF06B6D4)
                      : Colors.white.withValues(alpha: 0.12),
                  fontSize: 12,
                  fontWeight:
                      isCurrentRow ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: RichText(text: TextSpan(children: spans)),
              ),
            ),
          ],
        ),
      ));
    }
    return widgets;
  }
}
