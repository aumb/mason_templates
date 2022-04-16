# Freezed cubit 🧊

Generates a new freezed cubit, and its runner files in [Dart][1]. Built for the [flutter bloc state management library][2] with [freezed][3].

## Usage 🚀

Make sure that [freezed][3], [freezed_annotation][3], [flutter_bloc][2], and [build_runner][4] are added to your `pubspec.yaml`.

```sh
mason make freezed_cubit
```

## Variables ✨

| Variable | Description                | Default   | Type     |
| -------- | -------------------------- | --------- | -------- |
| `name`   | The name of the cubit class | `counter` | `string` |
| `generate_status`   | Whether to generate a status class for the cubit | `true` | `boolean` |

## Output 📦

```sh
├── counter_cubit.dart
└── counter_state.dart
```

[1]: https://dart.dev
[2]: https://github.com/felangel/bloc/tree/master/packages/flutter_bloc
[3]: https://github.com/rrousselGit/freezed
[4]: https://github.com/dart-lang/build/tree/master/build_runner
