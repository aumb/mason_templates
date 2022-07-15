import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final initialDirectory = Directory.current;

  final progress = context.logger.progress('');

  try {
    final path = context.vars['path'] as String;
    final name = context.vars['name'] as String;

    progress.update('Generating test file at $path');
    await _generateTestFile(
      path,
      name,
      context.logger,
    );
    progress.complete('Generated test file at ${Directory.current}');
  } catch (e) {
    progress.fail(e.toString());
  } finally {
    Directory.current = initialDirectory;
    context.logger.progress('Reset the current directory to its initial value')
      ..complete();
  }
}

Future<void> _generateTestFile(
  String path,
  String name,
  Logger logger,
) async {
  final ensureCaps = name.capitalizeFirst;
  final ensureLowerCase = name.toLowerCase();

  final progress = logger.progress('');

  if (path.isNotEmpty) {
    progress.update('Custom path detected...generating directories');
    await _verifyAndCreateDirectories(path);
    progress.complete('Generated all directories...generating test file');
  } else {
    progress.complete('Root path detected...generating test file');
  }

  await File('${ensureLowerCase}_cubit_test.dart').writeAsString(
    '''
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
//TODO: import cubit location
//TODO: import mock package

void main() {
  ${ensureCaps}Cubit cubit() => ${ensureCaps}Cubit();

  group('${ensureCaps}Cubit', () {
    blocTest<${ensureCaps}Cubit, ${ensureCaps}State>(
      'emits initial state',
      build: cubit,
      verify: (cubit) => expect(
        cubit.state,
        equals(
          ${ensureCaps}State.initial(),
        ),
      ),
    );
  });
}

''',
  );
}

Future<void> _verifyAndCreateDirectories(
  String path,
) async {
  final folders = path.split('/');

  for (final folder in folders) {
    final directoryExists = await Directory(folder).exists();

    if (!directoryExists) {
      Directory.current = await Directory(folder).create();
    } else {
      Directory.current = Directory(folder);
    }
  }
}

extension StringX on String {
  String get capitalizeFirst => this[0].toUpperCase() + this.substring(1);
}
