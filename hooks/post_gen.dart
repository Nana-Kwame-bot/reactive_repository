import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final bloc_state_name = context.vars['bloc_state_name'];

  final fileName = '${_toSnakeCase(bloc_state_name)}_repository.dart';

  final currentDir = Directory.current.path;

  final filePath = '$currentDir/$fileName';

  final progress = context.logger.progress('Formatting code in $fileName');

  // Run `dart format` on the specific file.
  final result = await Process.run('dart', ['format', filePath]);

  if (result.exitCode == 0) {
    progress.complete("$fileName formatted successfully.");
  } else {
    progress.fail("Failed to format $fileName. Error: ${result.stderr}");
  }
}

String _toSnakeCase(String input) {
  return input
      .replaceAllMapped(RegExp(r'[A-Z]'),
          (Match match) => '_${match.group(0)?.toLowerCase()}')
      .replaceFirst(RegExp(r'^_'), '');
}
