List<int> longestCommonSubsequenceIndexes(
  List<String> source,
  List<String> target, {
  bool ignoreSymbol = true,
}) {
  final int m = source.length;
  final int n = target.length;

  final List<List<int>> dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));

  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      if (source[i - 1] == target[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1] + 1;
      } else {
        dp[i][j] = dp[i - 1][j] > dp[i][j - 1] ? dp[i - 1][j] : dp[i][j - 1];
      }
    }
  }

  int i = m, j = n;
  final List<int> indexes = [];

  while (i > 0 && j > 0) {
    if (source[i - 1] == target[j - 1]) {
      indexes.insert(0, i - 1);
      i--;
      j--;
    } else if (dp[i - 1][j] > dp[i][j - 1]) {
      i--;
    } else {
      j--;
    }
  }
  List<int> symbolIndexes = [];
  if (ignoreSymbol) {
    for (int i = 0; i < source.length; i++) {
      if (!isNotSymbol(source[i])) {
        symbolIndexes.add(i);
      }
    }
  }
  return mergeSortedUnique(indexes, symbolIndexes);
}

List<int> mergeSortedUnique(List<int> a, List<int> b) {
  Set<int> mergedSet = {...a, ...b};
  List<int> result = mergedSet.toList()..sort();
  return result;
}

/// This function checks if the character is not a symbol.
/// Special note: This function is used to Japanese and English.
bool isNotSymbol(String character) {
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

List<int> findIndexWithSymbol(
  String text,
  String symbol, {
  String ignoreSymbol = '',
}) {
  assert(symbol != ignoreSymbol);
  final List<int> indices = <int>[];
  bool isInSymbol = false;
  int actualIndex = 0;

  for (int i = 0; i < text.length; i++) {
    final String char = text[i];

    if (char == symbol) {
      if (!isInSymbol) {
        isInSymbol = true;
      } else {
        isInSymbol = false;
      }
    } else if (char != ignoreSymbol) {
      if (isInSymbol) {
        indices.add(actualIndex);
      }
      actualIndex++;
    }
  }

  return indices;
}
