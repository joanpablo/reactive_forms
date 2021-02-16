class MockPattern implements Pattern {
  final Pattern pattern;

  MockPattern(this.pattern);

  @override
  Iterable<Match> allMatches(String string, [int start = 0]) {
    return pattern.allMatches(string);
  }

  @override
  Match? matchAsPrefix(String string, [int start = 0]) {
    return pattern.matchAsPrefix(string);
  }

}