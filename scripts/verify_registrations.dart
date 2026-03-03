import 'dart:io';

/// Script to verify that all Services, Repositories, and UseCases
/// are registered in the service locator.
void main() {
  print('🔍 Verifying Service Locator Registrations...');

  final locatorFile = File('lib/core/service_locator.dart');
  if (!locatorFile.existsSync()) {
    print('❌ Error: lib/core/service_locator.dart not found.');
    exit(1);
  }

  final locatorContent = locatorFile.readAsStringSync();

  // Folders to scan
  final scanDirs = [Directory('lib/features'), Directory('lib/core')];

  // Regex to find class declarations ending in Service, Repository, UseCase
  final classRegex = RegExp(
    r'(abstract\s+)?class\s+([A-Z]\w*(?:Service|Repository|UseCase|Usecase|DataSource))\b',
  );
  final missingRegistrations = <String, String>{};

  for (var dir in scanDirs) {
    if (!dir.existsSync()) continue;

    dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .forEach((file) {
          final fileName = file.path.split(Platform.pathSeparator).last;

          // Skip the locator file itself and other non-relevant files
          if (fileName == 'service_locator.dart') return;
          if (fileName.contains('test.dart')) return;
          if (fileName.contains('verification.dart')) return;

          // Skip internal core utility paths
          if (file.path.contains('lib/core/base')) return;
          if (file.path.contains('lib/core/network')) return;

          final content = file.readAsStringSync();
          final matches = classRegex.allRegexMatches(content);

          for (final match in matches) {
            final className = match.group(2)!;

            // Skip common ignore patterns
            if (className.startsWith('Base')) continue;
            if (className.endsWith('ApiService')) continue;
            if (className.endsWith('Mock')) continue;

            // Check if the class name mentioned in the locator?
            if (!locatorContent.contains(className)) {
              missingRegistrations[className] = file.path;
            }
          }
        });
  }

  if (missingRegistrations.isEmpty) {
    print(
      '✅ Success! All identified components are registered in service_locator.dart.',
    );
  } else {
    print(
      '\n❌ Found ${missingRegistrations.length} missing registration(s):\n',
    );
    missingRegistrations.forEach((className, path) {
      print('  • $className (at $path)');
    });
    print('\n💡 Please add these to lib/core/service_locator.dart');
    print(
      '💡 If this is an intentional exclusion, you can add an ignore rule in scripts/verify_registrations.dart',
    );
    exit(1);
  }
}

extension on RegExp {
  Iterable<RegExpMatch> allRegexMatches(String input) {
    return allMatches(input);
  }
}
