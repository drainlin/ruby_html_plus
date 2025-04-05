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

  ///
  static List<int> findIndexWithSymbol(
    String text,
    String symbol, {
    String ignoreSymbol = '',
  }) {
    assert(symbol != ignoreSymbol);
    List<int> indices = [];
    bool isInSymbol = false; // 标记是否在符号之间
    int actualIndex = 0; // 用来记录去除符号后的字符的索引

    for (int i = 0; i < text.length; i++) {
      final char = text[i];

      if (char == symbol) {
        if (!isInSymbol) {
          // 遇到开始符号，开始标记区间
          isInSymbol = true;
        } else {
          // 遇到结束符号，结束符号区间
          isInSymbol = false;
        }
      } else if (char != ignoreSymbol) {
        // 如果当前字符不是忽略符号并且当前在符号区间内，记录索引
        if (isInSymbol) {
          indices.add(actualIndex);
        }
        actualIndex++; // 仅增加去除符号后的字符索引
      }
      // 如果是忽略的符号，跳过并不增加 actualIndex
    }

    return indices;
  }
}
