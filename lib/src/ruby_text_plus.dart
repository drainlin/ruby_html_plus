import 'package:flutter/material.dart';
import 'package:ruby_text/ruby_text.dart';
import 'package:ruby_text_plus/src/model/ruby_text_plus_data.dart';

class RubyTextPlus extends StatelessWidget {
  final String html;
  final bool shouldShowRubyText;
  final bool shouldTrimSpacingIfNotShowRubyText;
  final TextStyle? textStyle;
  final TextStyle? rubyTextStyle;

  const RubyTextPlus(
    this.html, {
    super.key,
    this.shouldShowRubyText = true,
    this.textStyle,
    this.rubyTextStyle,
    this.shouldTrimSpacingIfNotShowRubyText = true,
  });

  @override
  Widget build(BuildContext context) {
    return RubyText(
      _data(context).splitRubyTextDataList,
      // spacing: 0.0,
      // style: null,
      // rubyStyle: null,
      // textAlign: null,
      // textDirection: null,
      // softWrap: null,
      // overflow: null,
      // maxLines: null,
    );
  }

  RubyTextPlusData _data(BuildContext context) {
    return RubyTextPlusData(
      html,
      shouldShowRubyText: shouldShowRubyText,
      context: context,
      textStyle: textStyle,
      rubyTextStyle: rubyTextStyle,
      shouldTrimSpacingIfNotShowRubyText: shouldTrimSpacingIfNotShowRubyText,
    );
  }

  static Widget highlightMatchingText(
    String html, {
    required String plainText,
    required String matchingText,
    required BuildContext context,
    Color matchedColor = Colors.green,
    bool shouldShowRubyText = true,
    bool shouldTrimSpacingIfNotShowRubyText = true,
    TextStyle? textStyle,
    TextStyle? rubyTextStyle,
  }) {
    final data = RubyTextPlusData(
      html,
      shouldShowRubyText: shouldShowRubyText,
      context: context,
      textStyle: textStyle,
      rubyTextStyle: rubyTextStyle,
      shouldTrimSpacingIfNotShowRubyText: shouldTrimSpacingIfNotShowRubyText,
    );
    var textDataList = data.splitRubyTextDataList;
    final List<String> plainTextList =
        textDataList.map((e) {
          return e.text;
        }).toList();
    final List<String> matchingTextList = splitJapaneseText(matchingText);
    final list = findMatchingIndices(plainTextList, matchingTextList);
    for (var index in list) {
      textDataList[index] = textDataList[index].copyWith(
        style: textDataList[index].style?.copyWith(color: matchedColor),
        rubyStyle: textDataList[index].rubyStyle?.copyWith(color: matchedColor),
      );
    }

    return RubyText(textDataList);
  }

  static bool isJapaneseOrEnglishCharacter(String character) {
    if (character.isEmpty) return false;
    final int code = character.codeUnitAt(0);

    return (code >= 0x3040 && code <= 0x309F) || // 平假名
        (code >= 0x30A0 && code <= 0x30FF) || // 片假名
        (code >= 0x4E00 && code <= 0x9FFF) || // CJK 统一汉字
        (code >= 0x3400 && code <= 0x4DBF) || // CJK 扩展 A
        (code >= 0x0041 && code <= 0x005A) || // A-Z
        (code >= 0x0061 && code <= 0x007A); // a-z
  }

  static List<int> findMatchingIndices(
      List<String> correctList,
      List<String> matchList,
      ) {
    List<int> indices = [];
    int correctListIndex = 0;

    for (var i in matchList) {
      // 从上次匹配的索引 correctListIndex 开始查找
      for (int j = correctListIndex; j < correctList.length; j++) {
        // 如果找到匹配的元素
        if (correctList[j] == i) {
          indices.add(j);
          correctListIndex = j + 1;  // 更新 correctListIndex，避免重复匹配
          break;
        } else if (!isJapaneseOrEnglishCharacter(correctList[j])) {
          // 如果是非日文或英文字符，仍然加到结果中
          indices.add(j);
        }
      }
    }

    // 去重并排序
    indices = indices.toSet().toList();
    indices.sort();

    return indices;
  }

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
