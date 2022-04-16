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
class {{name.pascalCase()}}Status<T> with _${{name.pascalCase()}}Status<T> {
  const factory {{name.pascalCase()}}Status.initial() = Initial<T>;

  const factory {{name.pascalCase()}}Status.loading() = Loading<T>;

  const factory {{name.pascalCase()}}Status.success() = Success<T>;

  const factory {{name.pascalCase()}}Status.failure(Error error) = Failure<T>;
}

extension {{name.pascalCase()}}StatusExtension<T> on {{name.pascalCase()}}Status<T> {
  bool get isInitial => this is Initial<T>;

  bool get isLoading => this is Loading<T>;

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;
}
{{/generate_status}}
