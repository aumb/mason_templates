part of '{{name.snakeCase()}}_cubit.dart';

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const {{name.pascalCase()}}State._();

  {{#generate_status}}
  factory {{name.pascalCase()}}State({
    required {{name.pascalCase()}}Status status,
  }) = _{{name.pascalCase()}}State;

  factory {{name.pascalCase()}}State.initial() {
    return {{name.pascalCase()}}State(
      status: const {{name.pascalCase()}}Status.initial(),
    );
  }
  {{/generate_status}}

  {{^generate_status}}
  factory {{name.pascalCase()}}State() = _{{name.pascalCase()}}State;

  factory {{name.pascalCase()}}State.initial() {
    return {{name.pascalCase()}}State(
    );
  }
  {{/generate_status}}
}

{{#generate_status}}
@freezed
class {{name.pascalCase()}}Status with _${{name.pascalCase()}}Status {
  const factory {{name.pascalCase()}}Status.initial() = Initial;

  const factory {{name.pascalCase()}}Status.loading() = Loading;

  const factory {{name.pascalCase()}}Status.success() = Success;

  const factory {{name.pascalCase()}}Status.failure(Error error) = Failure;
}

extension {{name.pascalCase()}}StatusExtension on {{name.pascalCase()}}Status {
  bool get isInitial => this is Initial;

  bool get isLoading => this is Loading;

  bool get isSuccess => this is Success;

  bool get isFailure => this is Failure;
}
{{/generate_status}}
