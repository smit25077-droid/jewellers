import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// This test enforces that all Services, Repositories, and UseCases
/// are registered in lib/core/service_locator.dart.
/// Failure to register a core component will fail this test.
void main() {
  test(
    'All Services, Repositories, and UseCases should be registered in service_locator.dart',
    () {
      final locatorFile = File('lib/core/service_locator.dart');
      expect(
        locatorFile.existsSync(),
        true,
        reason: 'service_locator.dart not found',
      );

      final locatorContent = locatorFile.readAsStringSync();

      // Folders to scan
      final scanDirs = [Directory('lib/features'), Directory('lib/core')];

      // Regex to find class declarations ending in Service, Repository, UseCase
      final classRegex = RegExp(
        r'(abstract\s+)?class\s+([A-Z]\w*(?:Service|Repository|UseCase|Usecase|DataSource))\b',
      );
      final missingRegistrations = <String>[];

      for (var dir in scanDirs) {
        if (!dir.existsSync()) continue;

        final files = dir
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart'));

        for (final file in files) {
          final fileName = file.path.split(Platform.pathSeparator).last;

          // Skip the locator file itself and other non-relevant files
          if (fileName == 'service_locator.dart' ||
              fileName.contains('test.dart') ||
              fileName.contains('verification.dart')) {
            continue;
          }

          // Skip internal core utility paths
          if (file.path.contains('lib/core/base') ||
              file.path.contains('lib/core/network')) {
            continue;
          }

          final content = file.readAsStringSync();
          final matches = classRegex.allMatches(content);

          for (final match in matches) {
            final className = match.group(2)!;

            // Skip common ignore patterns
            if (className.startsWith('Base') ||
                className.endsWith('ApiService') ||
                className.endsWith('Mock')) {
              continue;
            }

            // Check if the class name mentioned in the locator?
            if (!locatorContent.contains(className)) {
              missingRegistrations.add('$className (at ${file.path})');
            }
          }
        }
      }

      if (missingRegistrations.isNotEmpty) {
        fail(
          '❌ Found ${missingRegistrations.length} missing registration(s) in service_locator.dart:\n\n' +
              missingRegistrations.map((e) => '  • $e').join('\n') +
              '\n\n💡 Please register these in lib/core/service_locator.dart',
        );
      }
    },
  );
}
