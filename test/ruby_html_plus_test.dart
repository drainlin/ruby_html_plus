import 'package:ruby_html_plus/src/tools/tool.dart';
import 'package:test/test.dart';

void main() {
  test('SplitJapaneseText', () {
    expect(Tool.splitJapaneseText("こんにちは"), equals(["こ", "ん", "に", "ち", "は"]));
    expect(
      Tool.splitJapaneseText("こんにちは、世界！"),
      equals(["こ", "ん", "に", "ち", "は", "、", "世界", "！"]),
    );
    expect(Tool.splitJapaneseText('abcd'), equals(['a', 'b', 'c', 'd']));
    expect(
      Tool.splitJapaneseText('昨日は雨だったのに、今日は晴です。'),
      equals([
        '昨日',
        'は',
        '雨',
        'だ',
        'っ',
        'た',
        'の',
        'に',
        '、',
        '今日',
        'は',
        '晴',
        'で',
        'す',
        '。',
      ]),
    );
    expect(Tool.splitJapaneseText(''), equals([]));
    expect(Tool.splitJapaneseText(' '), equals([' ']));
    expect(Tool.splitJapaneseText('  '), equals([' ', ' ']));
  });

  test('IsNotSymbol', () {
    expect(Tool.isNotSymbol('character'), equals(true));
    expect(Tool.isNotSymbol('.'), equals(false));
    expect(Tool.isNotSymbol('。'), equals(false));
    expect(Tool.isNotSymbol('！！'), equals(false));
    expect(Tool.isNotSymbol('「'), equals(false));
    expect(Tool.isNotSymbol('ああ'), equals(true));
    expect(Tool.isNotSymbol('English'), equals(true));
    expect(Tool.isNotSymbol('1'), equals(true));
  });

  test('FindMatchingIndices', () {
    expect(Tool.findMatchingIndices([], []), equals([]));
    expect(
      Tool.findMatchingIndices(["1", "2", "3", "4", "5"], ["3", "5"]),
      equals([2, 4]),
    );
    expect(
      Tool.findMatchingIndices(
        ['h', 'e', 'l', 'l', 'o'],
        ['h', 'o', 'l', 'l', 'a'],
      ),
      equals([0, 4]),
    );
    expect(
      Tool.findMatchingIndices(
        ['h', 'o', 'w', ',', 'a', 'r', 'e', 'y', 'o', 'u'],
        ['h', 'o', 'y', 'u', 'a'],
      ),
      equals([0, 1, 3, 7, 9]),
    );

    expect(
      Tool.findMatchingIndices(
        ['h', 'e', ' ', 'l', 'o'],
        ['h', 'o', 'l', 'l', 'a'],
      ),
      equals([0, 2, 4]),
    );
  });
}
