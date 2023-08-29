import 'dart:convert';

import 'package:unidecode/data/data.dart';

import 'no_replacement_behavior.dart';
import 'errors.dart';

/// This class transliterates Unicode strings to ASCII-only strings.
class UniDecode extends Converter<String, String> {
  const UniDecode(
      {this.noReplacementBehavior = NoReplacementBehavior.ignore,
      this.expectAscii = true,
      this.replaceString = ""});

  /// Behavior when encountering characters that no replacement was found for.
  final NoReplacementBehavior noReplacementBehavior;

  /// Whether [input] should be immediately returned unchanged before
  /// processing if [input] is already ASCII-only.
  final bool expectAscii;

  /// String to replace unfound characters with if [noReplacementBehavior] is [replace].
  final String replaceString;

  /// Transliterates [input] to a [String] containing only ASCII characters.
  @override
  String convert(String input) {
    if (expectAscii && _isAscii(input)) {
      return input;
    }

    return input.split("").map((char) {
      final replacement = _findReplacementChar(char);

      if (replacement == null) {
        switch (noReplacementBehavior) {
          case NoReplacementBehavior.ignore:
            return "";
          case NoReplacementBehavior.strict:
            throw NoReplacementError(char);
          case NoReplacementBehavior.replace:
            return replaceString;
          case NoReplacementBehavior.preserve:
            return char;
        }
      }

      return replacement;
    }).join("");
  }

  String? _findReplacementChar(String char) {
    final codeUnit = char.codeUnitAt(0);

    // Return unchanged if char is in ASCII range.
    if (codeUnit < 0x80) {
      return char;
    }

    // No data for characters in the Private Use Are and above.
    if (codeUnit > 0xeffff) {
      return null;
    }

    final sectionIndex = codeUnit >> 8;
    final position = codeUnit % 256;

    final section = data[sectionIndex];

    if (section == null) {
      return null;
    }

    try {
      return section[position];
    } on RangeError {
      return null;
    }
  }

  bool _isAscii(String string) {
    try {
      ascii.encode(string);
      return true;
    } on ArgumentError {
      return false;
    }
  }
}
