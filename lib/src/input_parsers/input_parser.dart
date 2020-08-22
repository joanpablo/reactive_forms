/// Represents the base class for input parsers.
///
/// This class is responsible for transforming [String] values in another
/// data type value.
abstract class InputParser<T> {
  /// Parses the [value] and returns the specified data type.
  T parse(String value);
}
