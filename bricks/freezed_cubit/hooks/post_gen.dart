import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Generating freezed files');

  try {
    final pathForTest = context.vars['path_for_test'] as String;

    await _generateFreezedFiles();
    progress.complete('Generated freezed files');

    if (pathForTest.isNotEmpty) {
      final name = context.vars['name'] as String;

      final code = await _generateTestFiles(
        name,
        pathForTest,
      );

      ///Flushes and exists the code, as we are running out of context of the
      ///mason CLI (which does this automatically)
      return Future.wait<void>([stdout.close(), stderr.close()])
          .then<void>((_) => exit(code));
    }
  } on GenerateFreezedFileException catch (e) {
    progress.fail('Generating freezed files failed ${e.toString()}');
  } on GenerateTestFileException catch (e) {
    progress.fail('Generating test files failed ${e.toString()}');
  } catch (e) {
    progress.fail('Generation failed ${e.toString()}');
  }
}

Future<void> _generateFreezedFiles() {
  try {
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
  } catch (e, s) {
    throw GenerateFreezedFileException(e, s);
  }
}

Future<int> _generateTestFiles(
  String name,
  String pathForTest,
) async {
  try {
    final brick = Brick(
      name: 'freezed_cubit_test',
      location: const BrickLocation(version: 'any'),
    );

    final generator = await MasonGenerator.fromBrick(brick);

    await generator.hooks.postGen(vars: {
      'name': name,
      'path': pathForTest,
    });

    return ExitCode.success.code;
  } catch (e, s) {
    throw GenerateTestFileException(e, s);
  }
}

abstract class GenerateException implements Exception {
  const GenerateException(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;
}

class GenerateTestFileException extends GenerateException {
  const GenerateTestFileException(super.error, super.stackTrace);
}

class GenerateFreezedFileException extends GenerateException {
  const GenerateFreezedFileException(super.error, super.stackTrace);
}
