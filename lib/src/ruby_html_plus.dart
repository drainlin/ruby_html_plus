import 'package:flutter/material.dart';
import 'package:ruby_html_plus/src/ruby_text/ruby_text.dart';
import 'package:ruby_html_plus/src/ruby_text/ruby_text_data.dart';
import 'package:ruby_html_plus/src/utils/utils.dart';

import 'model/ruby_html_plus_data.dart';

class RubyHtmlPlus extends StatelessWidget {
  /// Original text with ruby
  final String html;

  /// Whether to show ruby text
  final bool shouldShowRubyText;

  /// If [shouldShowRubyText] is false,
  /// whether to remove spacing
  /// instead of showing transparent text
  final bool shouldTrimSpacingIfNotShowRubyText;

  /// TextStyle for main text
  final TextStyle textStyle;

  /// TextStyle for ruby text
  final TextStyle rubyTextStyle;

  /// List of indices to be bold
  final List<int> boldIndex;

  /// Bold font weight
  final FontWeight boldFontWeight;

  /// TextAlign for the text
  final TextAlign textAlign;

  /// The text to be matched
  final String matchingText;

  /// The color to highlight the matching text
  final Color matchedColor;

  /// The color to highlight the matching overlay text
  final Color matchedOverlayColor = const Color(0xFFF9F2EB);

  /// The color to highlight the matching text
  final Color matchedTextColor = Colors.transparent;

  /// The color to highlight the matching ruby text
  final Color matchedRubyColor = Colors.transparent;

  /// Whether to ignore symbols in the plain text
  final bool ignoreSymbol;

  const RubyHtmlPlus(
    this.html, {
    super.key,
    this.shouldShowRubyText = true,
    this.boldIndex = const <int>[],
    this.boldFontWeight = FontWeight.w600,
    this.textStyle = const TextStyle(fontSize: 20),
    this.rubyTextStyle = const TextStyle(fontSize: 11, color: Colors.grey),
    this.shouldTrimSpacingIfNotShowRubyText = true,
    this.textAlign = TextAlign.start,
    this.matchingText = '',
    this.matchedColor = Colors.green,
    this.ignoreSymbol = true,
  });

  @override
  Widget build(BuildContext context) {
    final List<RubyTextData> dataList = RubyHtmlPlusData(
      html,
      shouldShowRubyText: shouldShowRubyText,
      context: context,
      textStyle: textStyle,
      rubyTextStyle: rubyTextStyle,
      shouldTrimSpacingIfNotShowRubyText: shouldTrimSpacingIfNotShowRubyText,
    ).splitRubyTextDataList;
    _matchBold(boldIndex, dataList, boldFontWeight);
    _matchHighLight(
      matchingText,
      dataList,
      matchedColor: matchedColor,
      ignoreSymbol: ignoreSymbol,
      matchedOverlayColor: matchedOverlayColor,
      matchedTextColor: matchedTextColor,
      matchedRubyColor: matchedRubyColor,
    );
    return RubyText(dataList, textAlign: textAlign);
  }

  static Widget overlay(
    /// Original text with ruby
    String html, {
    /// The text without ruby markup
    required List<int> overlayIndex,

    /// The text to be matched
    String matchingText = '',

    /// The color to highlight the matching text
    Color matchedColor = Colors.green,

    /// The color to highlight the matching overlay text
    Color matchedOverlayColor = const Color(0xFFF9F2EB),

    /// The color to highlight the matching text
    Color matchedTextColor = Colors.transparent,

    /// The color to highlight the matching ruby text
    Color matchedRubyColor = Colors.transparent,

    /// Whether to ignore symbols in the plain text
    bool ignoreSymbol = true,

    /// The text to be matched
    List<int> boldIndex = const <int>[],

    /// Bold font weight
    FontWeight boldFontWeight = FontWeight.w600,

    /// The context for getting default text style
    required BuildContext context,

    /// The color to highlight the matching text
    Color overlayColor = Colors.grey,

    /// Whether to ignore symbols in the plain text
    bool shouldShowRubyText = true,

    /// Whether to ignore symbols in the plain text
    /// If [shouldShowRubyText] is false,
    /// whether to remove spacing
    bool shouldTrimSpacingIfNotShowRubyText = true,

    /// TextStyle for main text
    TextStyle textStyle = const TextStyle(fontSize: 20, color: Colors.grey),

    /// TextStyle for ruby text
    TextStyle rubyTextStyle = const TextStyle(fontSize: 11, color: Colors.grey),

    /// TextAlign for the text
    TextAlign textAlign = TextAlign.start,

    /// Should overlay be full
    bool fullOverlay = true,
  }) {
    final RubyHtmlPlusData data = RubyHtmlPlusData(
      html,
      shouldShowRubyText: shouldShowRubyText,
      context: context,
      textStyle: textStyle,
      rubyTextStyle: rubyTextStyle,
      shouldTrimSpacingIfNotShowRubyText: shouldTrimSpacingIfNotShowRubyText,
    );
    final List<RubyTextData> textDataList = data.splitRubyTextDataList;

    _matchOverlay(overlayIndex, textDataList, overlayColor);
    _matchBold(boldIndex, textDataList, boldFontWeight);
    _matchHighLight(
      matchingText,
      textDataList,
      matchedColor: matchedColor,
      ignoreSymbol: ignoreSymbol,
      matchedOverlayColor: matchedOverlayColor,
      matchedTextColor: matchedTextColor,
      matchedRubyColor: matchedRubyColor,
    );

    return RubyText(
      textDataList,
      textAlign: textAlign,
      fullOverlay: fullOverlay,
    );
  }

  static Widget overlayWithSymbol(
    String htmlWithSymbol, {
    /// Plain Text with symbols
    String? plainTextWithSymbol,

    /// The text to be matched
    String matchingText = '',

    /// The color to highlight the matching text
    Color matchedColor = Colors.green,

    /// The color to highlight the matching overlay text
    Color matchedOverlayColor = const Color(0xFFF9F2EB),

    /// The color to highlight the matching text
    Color matchedTextColor = Colors.transparent,

    /// The color to highlight the matching ruby text
    Color matchedRubyColor = Colors.transparent,

    /// Whether to ignore symbols in the plain text
    bool ignoreSymbol = true,

    /// The symbol to be used
    String overlaySymbol = '#',

    /// The symbol to be used
    String boldSymbol = '%',

    /// Bold font weight
    FontWeight boldFontWeight = FontWeight.w600,

    /// The context for getting default text style
    required BuildContext context,

    /// The color to highlight the matching text
    Color overlayColor = Colors.grey,

    /// Whether to ignore symbols in the plain text
    bool shouldShowRubyText = true,

    /// Whether to ignore symbols in the plain text
    /// If [shouldShowRubyText] is false,
    /// whether to remove spacing
    bool shouldTrimSpacingIfNotShowRubyText = true,

    /// TextStyle for main text
    TextStyle textStyle = const TextStyle(fontSize: 20),

    /// TextStyle for ruby text
    TextStyle rubyTextStyle = const TextStyle(fontSize: 11, color: Colors.grey),

    /// TextAlign for the text
    TextAlign textAlign = TextAlign.start,
  }) {
    String originalText = '';
    if (plainTextWithSymbol == null) {
      originalText = RubyHtmlPlusData(
        htmlWithSymbol,
        shouldShowRubyText: shouldShowRubyText,
        context: context,
        textStyle: textStyle,
        rubyTextStyle: rubyTextStyle,
        shouldTrimSpacingIfNotShowRubyText: shouldTrimSpacingIfNotShowRubyText,
      ).originalText;
    } else {
      originalText = plainTextWithSymbol;
    }

    final List<int> overlayIndex = findIndexWithSymbol(
      originalText,
      overlaySymbol,
      ignoreSymbol: boldSymbol,
    );

    final List<int> boldIndex = findIndexWithSymbol(
      originalText,
      boldSymbol,
      ignoreSymbol: overlaySymbol,
    );
    return RubyHtmlPlus.overlay(
      htmlWithSymbol.replaceAll(overlaySymbol, '').replaceAll(boldSymbol, ''),
      context: context,
      boldIndex: boldIndex,
      overlayIndex: overlayIndex,
      ignoreSymbol: ignoreSymbol,
      matchingText: matchingText,
      matchedColor: matchedColor,
      matchedOverlayColor: matchedOverlayColor,
      matchedTextColor: matchedTextColor,
      matchedRubyColor: matchedRubyColor,
      textStyle: textStyle,
      rubyTextStyle: rubyTextStyle,
      boldFontWeight: boldFontWeight,
      overlayColor: overlayColor,
      shouldShowRubyText: shouldShowRubyText,
      shouldTrimSpacingIfNotShowRubyText: shouldTrimSpacingIfNotShowRubyText,
      textAlign: textAlign,
    );
  }

  static void _matchBold(
    List<int> boldIndex,
    List<RubyTextData> textDataList,
    FontWeight boldFontWeight,
  ) {
    for (final int index in boldIndex) {
      int currentTextIndex = 0;

      for (int i = 0; i < textDataList.length; i++) {
        final RubyTextData data = textDataList[i];
        final int length = data.text.length;
        final int rangeLeft = currentTextIndex;
        final int rangeRight = currentTextIndex + length;

        if (rangeLeft <= index && rangeRight > index) {
          textDataList[i] = data.copyWith(
            style: data.style?.copyWith(fontWeight: boldFontWeight),
          );
          break;
        }

        currentTextIndex = rangeRight;
      }
    }
  }

  static void _matchHighLight(
    String? matchingText,
    List<RubyTextData> textDataList, {
    bool ignoreSymbol = true,
    Color matchedColor = Colors.green,
    Color matchedOverlayColor = const Color(0xFFF9F2EB),
    Color matchedTextColor = Colors.transparent,
    Color matchedRubyColor = Colors.transparent,
  }) {
    if (matchingText != null && matchingText.isNotEmpty) {
      final List<String> plainTextList = <String>[];
      final Map<int, int> convertedToOriginalIndexMap = <int, int>{};

      int globalIndex = 0;

      for (int i = 0; i < textDataList.length; i++) {
        final String text = textDataList[i].text;
        for (int j = 0; j < text.length; j++) {
          plainTextList.add(text[j]);
          convertedToOriginalIndexMap[globalIndex] = i;
          globalIndex++;
        }
      }
      final List<String> matchingTextList = matchingText.split('');
      final List<int> list = longestCommonSubsequenceIndexes(
        plainTextList,
        matchingTextList,
        ignoreSymbol: ignoreSymbol,
      );
      for (final int index in list) {
        final int? originalIndex = convertedToOriginalIndexMap[index];
        if (originalIndex == null) continue;
        if (textDataList[originalIndex].style?.backgroundColor != null) {
          textDataList[originalIndex] = textDataList[originalIndex].copyWith(
            style: textDataList[originalIndex].style?.copyWith(
                  backgroundColor: matchedOverlayColor,
                  color: matchedTextColor,
                ),
            rubyStyle: textDataList[originalIndex].rubyStyle?.copyWith(
                  backgroundColor: matchedOverlayColor,
                  color: matchedRubyColor,
                ),
          );
        } else {
          textDataList[originalIndex] = textDataList[originalIndex].copyWith(
            style: textDataList[originalIndex].style?.copyWith(
                  color: matchedColor,
                ),
            rubyStyle: textDataList[originalIndex].rubyStyle?.copyWith(
                  color: matchedColor,
                ),
          );
        }
      }
    }
  }

  static void _matchOverlay(
    List<int> overlayIndex,
    List<RubyTextData> textDataList,
    Color overlayColor,
  ) {
    for (final int index in overlayIndex) {
      int currentTextIndex = 0;

      for (int i = 0; i < textDataList.length; i++) {
        final RubyTextData data = textDataList[i];
        final int length = data.text.length;
        final int rangeLeft = currentTextIndex;
        final int rangeRight = currentTextIndex + length;

        if (rangeLeft <= index && rangeRight > index) {
          textDataList[i] = data.copyWith(
            style: data.style?.copyWith(
              backgroundColor: overlayColor,
              color: overlayColor,
            ),
            rubyStyle: data.rubyStyle?.copyWith(
              backgroundColor: overlayColor,
              color: overlayColor,
            ),
          );
          break;
        }

        currentTextIndex = rangeRight;
      }
    }
  }
}
