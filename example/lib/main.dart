import 'package:flutter/material.dart';
import 'package:ruby_html_plus/ruby_html_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isShowOverlay = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(title: Text("RubyTextPlus Example")),
        body: ListView(
          children: [
            _buildRubyHtml(),
            _buildRubyHtmlWithoutRuby(),
            _buildRubyHtmlWithHighlight(),
            _buildRubyHtmlOverlayWithIndex(),
            _buildRubyHtmlOverlayWithSymbols(),
            _buildRubyHtmlBoldWithIndex(),
            _buildRubyHtmlBoldWithSymbol(),
            _buildRubyHtmlPlainTextWithSymbols(),
          ],
        ),
      ),
    );
  }

  Widget _buildRubyHtml() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowOverlay = !isShowOverlay;
                });
              },
              child:
                  isShowOverlay
                      ? RubyHtmlPlus.overlayWithSymbol(
                        '<ruby>#昨日<rt>きのう</rt></ruby>は<ruby>雨#<rt>あめ</rt></ruby>%だったのに、%<ruby>今日<rt>きょう</rt></ruby>は<ruby>%晴<rt>はれ</rt></ruby>で%す。',
                        shouldShowRubyText: true,
                        context: context,
                      )
                      : RubyHtmlPlus(
                        '<ruby>昨日<rt>きのう</rt></ruby>は<ruby>雨<rt>あめ</rt></ruby>だったのに、<ruby>今日<rt>きょう</rt></ruby>は<ruby>晴<rt>はれ</rt></ruby>です。',
                        boldIndex: [1, 2, 3, 4, 5, 6, 7, 8, 13, 14],
                        shouldShowRubyText: true,
                      ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRubyHtmlWithoutRuby() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: RubyHtmlPlus(
              '<ruby>昨日<rt>きのう</rt></ruby>は<ruby>雨<rt>あめ</rt></ruby>だったのに、<ruby>今日<rt>きょう</rt></ruby>は<ruby>晴<rt>はれ</rt></ruby>です。',
              boldIndex: [1, 2, 3, 4, 5, 6, 7, 8, 13, 14],
              shouldShowRubyText: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRubyHtmlOverlayWithSymbols() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: RubyHtmlPlus.overlayWithSymbol(
              '<ruby>昨日<rt>きのう</rt></ruby>は<ruby>#雨#<rt>あめ</rt></ruby>だったのに、<ruby>今日<rt>きょう</rt></ruby>は<ruby>晴<rt>はれ</rt></ruby>です。',
              overlaySymbol: '#',
              shouldShowRubyText: true,
              context: context,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRubyHtmlWithHighlight() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: RubyHtmlPlus.overlay(
              'はい。「<ruby>週<rt>しゅう</rt></ruby>に4<ruby>日<rt>び</rt></ruby><ruby>働<rt>はたら</rt></ruby>けます。<ruby>月曜日<rt>げつようび</rt></ruby>と<ruby>水曜日<rt>すいようび</rt></ruby>がいいです。」',
              shouldShowRubyText: true,
              matchingText: 'はい週に4日働けます月曜日と水曜日がいいです',
              matchedColor: Color(0xffD14704),
              overlayIndex: [],
              context: context,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRubyHtmlOverlayWithIndex() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: RubyHtmlPlus.overlay(
              '<ruby>昨日<rt>きのう</rt></ruby>は<ruby>雨<rt>あめ</rt></ruby>だったのに、<ruby>今日<rt>きょう</rt></ruby>は<ruby>晴<rt>はれ</rt></ruby>です。',
              shouldShowRubyText: true,
              context: context,
              overlayIndex: [0, 1, 8],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRubyHtmlBoldWithIndex() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: RubyHtmlPlus(
              '<ruby>昨日<rt>きのう</rt></ruby>は<ruby>雨<rt>あめ</rt></ruby>だったのに、<ruby>今日<rt>きょう</rt></ruby>は<ruby>晴<rt>はれ</rt></ruby>です。',
              shouldShowRubyText: true,
              boldIndex: [0, 1, 3, 10, 11, 13],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRubyHtmlBoldWithSymbol() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: RubyHtmlPlus.overlayWithSymbol(
              '<ruby>昨日<rt>きのう</rt></ruby>は<ruby>雨<rt>あめ</rt></ruby>%だったのに、%<ruby>今日<rt>きょう</rt></ruby>は<ruby>晴<rt>はれ</rt></ruby>です。',
              shouldShowRubyText: true,
              boldSymbol: '%',
              overlaySymbol: '',
              context: context,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRubyHtmlPlainTextWithSymbols() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: RubyHtmlPlus.overlayWithSymbol(
              '<ruby>昨日<rt>きのう</rt></ruby>は<ruby>雨<rt>あめ</rt></ruby>だったのに、<ruby>今日<rt>きょう</rt></ruby>は<ruby>晴<rt>はれ</rt></ruby>です。',
              plainTextWithSymbol: "#昨日は雨#%だったのに%、今日は晴れです。",
              shouldShowRubyText: true,
              boldSymbol: '%',
              overlaySymbol: '#',
              boldFontWeight: FontWeight.w600,
              context: context,
            ),
          ),
        ),
      ],
    );
  }
}
