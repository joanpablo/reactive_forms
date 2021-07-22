/// Represents a class that evaluates a pattern
abstract class PatternEvaluator {
  /// Returns the string representation of the pattern
  String get pattern;

  /// Evaluates if the the patter has a match with the [input]
  bool hasMatch(String input);
}
