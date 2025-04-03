class Utils {
  static List<int> findMatchingIndices(
    List<String> correctList,
    List<String> matchList, {
    bool ignoreSymbol = true,
  }) {
    List<int> indices = [];
    int correctListIndex = 0;

    for (var i in matchList) {
      for (int j = correctListIndex; j < correctList.length; j++) {
        if (correctList[j] == i) {
          indices.add(j);
          correctListIndex = j + 1;
          break;
        } else if (!isNotSymbol(correctList[j])) {
          if (ignoreSymbol) {
            indices.add(j);
          }
        }
      }
    }

    indices = indices.toSet().toList();
    indices.sort();

    return indices;
  }

  /// This function checks if the character is not a symbol.
  /// Special note: This function is used to Japanese and English.
  static bool isNotSymbol(String character) {
    if (character.isEmpty) return false;
    final int code = character.codeUnitAt(0);

    return (code >= 0x3040 && code <= 0x309F) || // Hiragana
        (code >= 0x30A0 && code <= 0x30FF) || // Katakana
        (code >= 0x4E00 && code <= 0x9FFF) || // Common Kanji
        (code >= 0x3400 && code <= 0x4DBF) || // Extended Kanji
        (code >= 0x0041 && code <= 0x005A) || // A-Z
        (code >= 0x0061 && code <= 0x007A) || // a-z
        (code >= 0x0030 && code <= 0x0039); // 0-9 (Arabic numerals)
  }

  /// Special note: This function is used to Japanese.
  static List<String> splitJapaneseText(String text) {
    final List<String> result = [];
    final StringBuffer kanjiBuffer = StringBuffer();

    bool isKanji(int code) =>
        (code >= 0x4E00 && code <= 0x9FFF) ||
        (code >= 0x3400 && code <= 0x4DBF);

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      int code = char.codeUnitAt(0);

      if (isKanji(code)) {
        kanjiBuffer.write(char);
      } else {
        if (kanjiBuffer.isNotEmpty) {
          result.add(kanjiBuffer.toString());
          kanjiBuffer.clear();
        }
        result.add(char);
      }
    }

    if (kanjiBuffer.isNotEmpty) {
      result.add(kanjiBuffer.toString());
    }

    return result;
  }
}
