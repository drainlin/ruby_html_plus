import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

import '../ruby_text/ruby_text_data.dart';

class RubyHtmlPlusData {
  /// Context for getting default text style
  final BuildContext context;

  /// original text with ruby
  final String rubyText;

  /// Whether to show ruby text
  final bool shouldShowRubyText;

  /// If [shouldShowRubyText] is false,
  /// whether to remove spacing
  /// instead of showing transparent text
  final bool shouldTrimSpacingIfNotShowRubyText;

  /// TextStyle for main text
  final TextStyle? textStyle;

  /// TextStyle for ruby text
  final TextStyle? rubyTextStyle;

  RubyHtmlPlusData(
    this.rubyText, {
    required this.context,
    required this.shouldShowRubyText,
    required this.textStyle,
    required this.rubyTextStyle,
    required this.shouldTrimSpacingIfNotShowRubyText,
  });

  TextStyle? get _textRubyTextStyle {
    if (shouldShowRubyText) {
      return rubyTextStyle;
    } else {
      if (rubyTextStyle != null) {
        return rubyTextStyle!.copyWith(
          color: Colors.transparent,
          fontSize:
              shouldTrimSpacingIfNotShowRubyText ? 0 : rubyTextStyle?.fontSize,
        );
      } else {
        return DefaultTextStyle.of(context).style.copyWith(
              color: Colors.transparent,
              fontSize: shouldTrimSpacingIfNotShowRubyText
                  ? 0
                  : DefaultTextStyle.of(context).style.fontSize,
            );
      }
    }
  }

  List<RubyTextData> get splitRubyTextDataList {
    final List<RubyTextData> rubyTexts = <RubyTextData>[];

    final dom.Document document = parse(rubyText);
    for (final dom.Node node in document.body!.nodes) {
      if (node.nodeType == dom.Node.TEXT_NODE) {
        if (node.text != null && node.text!.isNotEmpty) {
          // plain text
          final List<String> splitText = node.text!.split('');

          for (final String char in splitText) {
            rubyTexts.add(
              RubyTextData(
                char,
                ruby: ' ',
                style: textStyle,
                rubyStyle: _textRubyTextStyle,
              ),
            );
          }
        }
      } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
        final dom.Element element = node as dom.Element;
        if (element.localName == 'ruby') {
          String mainText = '';
          String rubyText = '';
          for (final dom.Node subNode in element.nodes) {
            if (subNode.nodeType == dom.Node.TEXT_NODE) {
              mainText = subNode.text ?? '';
            } else if (subNode.nodeType == dom.Node.ELEMENT_NODE) {
              final dom.Element element = subNode as dom.Element;
              if (element.localName == 'rt') {
                rubyText = element.text;
              }
            }

            if (mainText.isNotEmpty && rubyText.isNotEmpty) {
              // main text and ruby text are not empty
              rubyTexts.add(
                RubyTextData(
                  mainText,
                  ruby: rubyText,
                  style: textStyle,
                  rubyStyle: _textRubyTextStyle,
                ),
              );

              mainText = '';
              rubyText = '';
            }
          }
        }
      }
    }

    return rubyTexts;
  }

  String get originalText {
    String text = '';
    for (final RubyTextData rubyText in splitRubyTextDataList) {
      text += rubyText.text;
    }
    return text;
  }
}
