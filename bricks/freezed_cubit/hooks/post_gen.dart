import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  context.logger.info('Generating freezed files');
  try {
    await _generateFreezedFiles();
    context.logger.info('Generated freezed files');
  } catch (e) {
    context.logger.err('Generating freezed files failed');
    context.logger.err(e.toString());
  }
}

Future<void> _generateFreezedFiles() {
  return Process.run(
    'flutter',
    [
      'pub',
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ],
  );
}
