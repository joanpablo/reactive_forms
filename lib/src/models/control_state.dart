/// Represent the state of a [FormControl].
class ControlState<T> {
  final T value;
  final bool disabled;

  /// Constructs a state with a default [value] and a [disabled] status.
  ControlState({
    this.value,
    this.disabled,
  });
}
