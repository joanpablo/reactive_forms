import 'package:reactive_forms/src/validators/pattern/pattern_evaluator.dart';

/// Evaluates a pattern using a native [Pattern] instance.
class DefaultPatternEvaluator implements PatternEvaluator {
  final Pattern _pattern;

  /// Constructs an instance of the class.
  /// The argument [pattern] must not be null.
  DefaultPatternEvaluator(Pattern pattern)
      : assert(pattern != null),
        _pattern = pattern;

  @override
  bool hasMatch(String input) => _pattern.allMatches(input).isNotEmpty;

  @override
  String get pattern => _pattern.toString();
}
