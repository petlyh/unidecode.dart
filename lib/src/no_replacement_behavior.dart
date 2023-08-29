/// Behavior when encountering a character that there isn't a replacement for.
enum NoReplacementBehavior {
  /// Ignore the character, replacing it with nothing.
  ignore,

  /// Throw a [NoReplacementError].
  strict,

  /// Replace with [replaceString].
  replace,

  /// Keep the original character as-is.
  preserve,
}
