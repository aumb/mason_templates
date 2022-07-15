# Freezed cubit test🧊

Generates a new freezed cubit test at the given path. Built for the [freezed_cubit template][1].

## Usage 🚀

Make sure that [bloc_test][2] and [flutter_test][3] are added to your `pubspec.yaml`.

```sh
mason make freezed_cubit_test
```

## Variables ✨

| Variable | Description                | Default   | Type     |
| -------- | -------------------------- | --------- | -------- |
| `path`   | The path where the test should be created |  | `string` |
| `name`   | The name of the cubit class | `counter` | `string` |

## Output 📦

```sh
├── counter_cubit_test.dart
```

[1]: https://github.com/aumb/mason_templates/tree/main/bricks/freezed_cubit
[2]: https://pub.dev/packages/bloc_test
[3]: https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html
