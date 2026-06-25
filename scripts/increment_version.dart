import 'dart:io';

void main() {
  final file = File('pubspec.yaml');
  if (!file.existsSync()) {
    // ignore: avoid_print
    print('pubspec.yaml not found');
    exit(1);
  }

  final content = file.readAsLinesSync();
  final newContent = <String>[];
  
  for (var line in content) {
    if (line.startsWith('version: ')) {
      final versionPart = line.replaceFirst('version: ', '').trim();
      final parts = versionPart.split('+');
      final version = parts[0];
      final buildNumber = int.parse(parts[1]);
      
      // Increment build number
      final newLine = 'version: $version+${buildNumber + 1}';
      // ignore: avoid_print
      print('Updating version from $versionPart to $version+${buildNumber + 1}');
      newContent.add(newLine);
    } else {
      newContent.add(line);
    }
  }

  file.writeAsStringSync(newContent.join('\n'));
}
