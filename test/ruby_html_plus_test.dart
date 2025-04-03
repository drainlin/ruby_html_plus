import 'package:ruby_html_plus/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  test('SplitJapaneseText', () {
    expect(Utils.splitJapaneseText("こんにちは"), equals(["こ", "ん", "に", "ち", "は"]));
    expect(
      Utils.splitJapaneseText("こんにちは、世界！"),
      equals(["こ", "ん", "に", "ち", "は", "、", "世界", "！"]),
    );
    expect(Utils.splitJapaneseText('abcd'), equals(['a', 'b', 'c', 'd']));
    expect(
      Utils.splitJapaneseText('昨日は雨だったのに、今日は晴です。'),
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
    expect(Utils.splitJapaneseText(''), equals([]));
    expect(Utils.splitJapaneseText(' '), equals([' ']));
    expect(Utils.splitJapaneseText('  '), equals([' ', ' ']));
  });

  test('IsNotSymbol', () {
    expect(Utils.isNotSymbol('character'), equals(true));
    expect(Utils.isNotSymbol('.'), equals(false));
    expect(Utils.isNotSymbol('。'), equals(false));
    expect(Utils.isNotSymbol('！！'), equals(false));
    expect(Utils.isNotSymbol('「'), equals(false));
    expect(Utils.isNotSymbol('ああ'), equals(true));
    expect(Utils.isNotSymbol('English'), equals(true));
    expect(Utils.isNotSymbol('1'), equals(true));
  });

  test('FindMatchingIndices', () {
    expect(Utils.findMatchingIndices([], []), equals([]));
    expect(
      Utils.findMatchingIndices(["1", "2", "3", "4", "5"], ["3", "5"]),
      equals([2, 4]),
    );
    expect(
      Utils.findMatchingIndices(
        ['h', 'e', 'l', 'l', 'o'],
        ['h', 'o', 'l', 'l', 'a'],
      ),
      equals([0, 4]),
    );
    expect(
      Utils.findMatchingIndices(
        ['h', 'o', 'w', ',', 'a', 'r', 'e', 'y', 'o', 'u'],
        ['h', 'o', 'y', 'u', 'a'],
      ),
      equals([0, 1, 3, 7, 9]),
    );

    expect(
      Utils.findMatchingIndices(
        ['h', 'e', ' ', 'l', 'o'],
        ['h', 'o', 'l', 'l', 'a'],
      ),
      equals([0, 2, 4]),
    );
  });
}
