import 'package:flutter/material.dart';

class TypingSyntaxHighlighter {
  static List<Color> tokenizeLine(String line) {
    List<Color> colors = List.filled(line.length, const Color(0xFFABB2BF)); // Default gray

    // Vibrant Neon Cyber Premium Palette (3D/Hard Glass Color Fix)
    const Color keywordColor = Color(0xFFD67CFF); // Vibrant Violet/Magenta
    const Color typeColor = Color(0xFFFFD369); // Vibrant Golden Yellow
    const Color propertyColor = Color(0xFFFF5E7E); // Vibrant Rose/Coral
    const Color methodColor = Color(0xFF00C3FF); // Vibrant Electric Blue
    const Color stringColor = Color(0xFF6EE7B7); // Vibrant Emerald Green
    const Color operatorColor = Color(0xFF00FFCC); // Vibrant Cyber Teal/Cyan

    // 1. Highlight Strings (e.g. "Anil Bhattarai", "Flutter", etc.)
    final stringRegex = RegExp(r'"[^"]*"');
    for (final match in stringRegex.allMatches(line)) {
      for (int i = match.start; i < match.end; i++) {
        colors[i] = stringColor;
      }
    }

    // Helper to check if a range of indices is already highlighted as a string
    bool isStringRange(int start, int end) {
      for (int i = start; i < end; i++) {
        if (colors[i] == stringColor) return true;
      }
      return false;
    }

    // 2. Keywords
    final keywords = ['class', 'void', 'final', 'const', 'var', 'return'];
    for (final keyword in keywords) {
      final regex = RegExp('\\b$keyword\\b');
      for (final match in regex.allMatches(line)) {
        if (!isStringRange(match.start, match.end)) {
          for (int i = match.start; i < match.end; i++) {
            colors[i] = keywordColor;
          }
        }
      }
    }

    // 3. Types (starts with uppercase)
    final typeRegex = RegExp(r'\b[A-Z][a-zA-Z0-9_]*\b');
    for (final match in typeRegex.allMatches(line)) {
      if (!isStringRange(match.start, match.end)) {
        for (int i = match.start; i < match.end; i++) {
          colors[i] = typeColor;
        }
      }
    }

    // 4. Properties/Identifiers
    final properties = ['name', 'skills'];
    for (final prop in properties) {
      final regex = RegExp('\\b$prop\\b');
      for (final match in regex.allMatches(line)) {
        if (!isStringRange(match.start, match.end)) {
          for (int i = match.start; i < match.end; i++) {
            colors[i] = propertyColor;
          }
        }
      }
    }

    // 5. Methods
    final methods = ['build'];
    for (final method in methods) {
      final regex = RegExp('\\b$method\\b');
      for (final match in regex.allMatches(line)) {
        if (!isStringRange(match.start, match.end)) {
          for (int i = match.start; i < match.end; i++) {
            colors[i] = methodColor;
          }
        }
      }
    }

    // 6. Operators/Punctuation
    final operators = ['=', '=>', '+', '-', '*', '/'];
    for (final op in operators) {
      int idx = -1;
      while ((idx = line.indexOf(op, idx + 1)) != -1) {
        if (!isStringRange(idx, idx + op.length)) {
          for (int i = 0; i < op.length; i++) {
            colors[idx + i] = operatorColor;
          }
        }
      }
    }

    final punctuations = ['{', '}', '[', ']', '(', ')', ';', ',', ':'];
    for (final p in punctuations) {
      int idx = -1;
      while ((idx = line.indexOf(p, idx + 1)) != -1) {
        if (!isStringRange(idx, idx + p.length)) {
          colors[idx] = operatorColor;
        }
      }
    }

    return colors;
  }
}
