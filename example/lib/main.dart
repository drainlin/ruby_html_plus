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
        body: Center(child: _buildBody()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      width: 350,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isShowOverlay = !isShowOverlay;
          });
        },
        child:
            isShowOverlay
                ? RubyHtmlPlus(
                  '<ruby>昨日<rt>きのう</rt></ruby>は<ruby>雨<rt>あめ</rt></ruby>だったのに、<ruby>今日<rt>きょう</rt></ruby>は<ruby>晴<rt>はれ</rt></ruby>です。',
                  boldIndex: [1, 2, 3, 4, 5, 6, 7, 8, 13, 14],
                  shouldShowRubyText: true,
                  rubyTextStyle: TextStyle(fontSize: 11, color: Colors.grey),
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                )
                : RubyHtmlPlus.overlayWithSymbol(
                  '<ruby>#昨日<rt>きのう</rt></ruby>は<ruby>雨#<rt>あめ</rt></ruby>%だったのに、%<ruby>今日<rt>きょう</rt></ruby>は<ruby>%晴<rt>はれ</rt></ruby>で%す。',
                  shouldShowRubyText: true,
                  rubyTextStyle: TextStyle(fontSize: 11, color: Colors.grey),
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  context: context,
                ),
      ),
    );
  }
}
