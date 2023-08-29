/// Error thrown when no replacement character
/// is found if [errorBehavior] is set to strict.
class NoReplacementError extends Error {
  /// Create a NoReplacementError with the provided [character].
  NoReplacementError(this.character);

  final String character;

  @override
  String toString() {
    return "No replacement found for character: $character";
  }
}
