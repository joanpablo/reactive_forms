import 'package:reactive_forms/src/validators/pattern/pattern_evaluator.dart';

/// Evaluates a pattern using a [RegExp].
class RegExpPatternEvaluator implements PatternEvaluator {
  final RegExp regExp;

  /// Constructs an instance of the class.
  /// The argument [regExp] must not be null.
  const RegExpPatternEvaluator(this.regExp);

  @override
  bool hasMatch(String input) {
    return regExp.hasMatch(input);
  }

  @override
  String get pattern => regExp.pattern;
}
