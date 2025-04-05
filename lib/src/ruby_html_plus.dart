import 'package:flutter/material.dart';
import 'package:ruby_html_plus/src/ruby_text/ruby_text.dart';
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
  final FontWeight fontWeight;

  const RubyHtmlPlus(
    this.html, {
    super.key,
    this.shouldShowRubyText = true,
    this.boldIndex = const [],
    this.fontWeight = FontWeight.w600,
    this.textStyle = const TextStyle(fontSize: 20),
    this.rubyTextStyle = const TextStyle(fontSize: 11, color: Colors.grey),
    this.shouldTrimSpacingIfNotShowRubyText = true,
  });

  @override
  Widget build(BuildContext context) {
    final dataList =
        RubyHtmlPlusData(
          html,
          shouldShowRubyText: shouldShowRubyText,
          context: context,
          textStyle: textStyle,
          rubyTextStyle: rubyTextStyle,
          shouldTrimSpacingIfNotShowRubyText:
              shouldTrimSpacingIfNotShowRubyText,
        ).splitRubyTextDataList;
    for (int index in boldIndex) {
      int currentTextIndex = 0;
      for (var data in dataList) {
        final length = data.text.length;
        final rangeLeft = currentTextIndex;
        final rangeRight = currentTextIndex + length;

        if (rangeLeft <= index && rangeRight > index) {
          dataList[dataList.indexOf(data)] = data.copyWith(
            style: data.style?.copyWith(fontWeight: fontWeight),
          );
        }
        currentTextIndex = rangeRight;
      }
    }
    return RubyText(dataList);
  }

  static Widget highlightMatchingText(
    /// Original text with ruby
    String html, {

    /// The text to be matched
    required String matchingText,

    /// The context for getting default text style
    required BuildContext context,

    /// The color to highlight the matching text
    Color matchedColor = Colors.green,

    /// Whether to ignore symbols in the plain text
    bool ignoreSymbol = true,

    /// Whether to show ruby text
    bool shouldShowRubyText = true,

    /// If [shouldShowRubyText] is false,
    /// whether to remove spacing
    /// instead of showing transparent text
    bool shouldTrimSpacingIfNotShowRubyText = true,

    /// TextStyle for main text
    TextStyle textStyle = const TextStyle(fontSize: 20),

    /// TextStyle for ruby text
    TextStyle rubyTextStyle = const TextStyle(fontSize: 11, color: Colors.grey),
  }) {
    final data = RubyHtmlPlusData(
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
    final List<String> matchingTextList = Utils.splitJapaneseText(matchingText);
    final list = Utils.findMatchingIndices(
      plainTextList,
      matchingTextList,
      ignoreSymbol: ignoreSymbol,
    );
    for (var index in list) {
      textDataList[index] = textDataList[index].copyWith(
        style: textDataList[index].style?.copyWith(color: matchedColor),
        rubyStyle: textDataList[index].rubyStyle?.copyWith(color: matchedColor),
      );
    }

    return RubyText(textDataList);
  }

  static Widget overlay(
    /// Original text with ruby
    String html, {

    /// The text without ruby markup
    required List<int> overlayIndex,

    /// The text to be matched
    List<int> boldIndex = const [],

    /// Bold font weight
    FontWeight fontWeight = FontWeight.w600,

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
  }) {
    final data = RubyHtmlPlusData(
      html,
      shouldShowRubyText: shouldShowRubyText,
      context: context,
      textStyle: textStyle,
      rubyTextStyle: rubyTextStyle,
      shouldTrimSpacingIfNotShowRubyText: shouldTrimSpacingIfNotShowRubyText,
    );
    var textDataList = data.splitRubyTextDataList;

    for (int index in overlayIndex) {
      int currentTextIndex = 0;
      for (var data in textDataList) {
        final length = data.text.length;
        final rangeLeft = currentTextIndex;
        final rangeRight = currentTextIndex + length;

        if (rangeLeft <= index && rangeRight > index) {
          textDataList[textDataList.indexOf(data)] = data.copyWith(
            style: data.style?.copyWith(
              backgroundColor: overlayColor,
              color: overlayColor,
            ),
            rubyStyle: data.rubyStyle?.copyWith(
              backgroundColor: overlayColor,
              color: overlayColor,
            ),
          );
        }
        currentTextIndex = rangeRight;
      }
    }

    for (int index in boldIndex) {
      int currentTextIndex = 0;
      for (var data in textDataList) {
        final length = data.text.length;
        final rangeLeft = currentTextIndex;
        final rangeRight = currentTextIndex + length;

        if (rangeLeft <= index && rangeRight > index) {
          textDataList[textDataList.indexOf(data)] = data.copyWith(
            style: data.style?.copyWith(fontWeight: fontWeight),
          );
        }
        currentTextIndex = rangeRight;
      }
    }

    return RubyText(textDataList);
  }

  static Widget overlayWithSymbol(
    String htmlWithSymbol, {

    /// The symbol to be used
    String overlaySymbol = '#',

    String boldSymbol = '%',

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
  }) {
    final originalText =
        RubyHtmlPlusData(
          htmlWithSymbol,
          shouldShowRubyText: shouldShowRubyText,
          context: context,
          textStyle: textStyle,
          rubyTextStyle: rubyTextStyle,
          shouldTrimSpacingIfNotShowRubyText:
              shouldTrimSpacingIfNotShowRubyText,
        ).originalText;
    final List<int> overlayIndex = Utils.findIndexWithSymbol(
      originalText,
      overlaySymbol,
      ignoreSymbol: boldSymbol,
    );

    final List<int> boldIndex = Utils.findIndexWithSymbol(
      originalText,
      boldSymbol,
      ignoreSymbol: overlaySymbol,
    );
    return RubyHtmlPlus.overlay(
      htmlWithSymbol.replaceAll(overlaySymbol, '').replaceAll(boldSymbol, ''),
      context: context,
      boldIndex: boldIndex,
      overlayIndex: overlayIndex,
      textStyle: textStyle,
      rubyTextStyle: rubyTextStyle,
      overlayColor: overlayColor,
      shouldShowRubyText: shouldShowRubyText,
      shouldTrimSpacingIfNotShowRubyText: shouldTrimSpacingIfNotShowRubyText,
    );
  }
}
