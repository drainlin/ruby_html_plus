import 'package:ruby_html_plus/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  test('IsNotSymbol', () {
    expect(isNotSymbol('character'), equals(true));
    expect(isNotSymbol('.'), equals(false));
    expect(isNotSymbol('。'), equals(false));
    expect(isNotSymbol('！！'), equals(false));
    expect(isNotSymbol('「'), equals(false));
    expect(isNotSymbol('ああ'), equals(true));
    expect(isNotSymbol('English'), equals(true));
    expect(isNotSymbol('1'), equals(true));
  });
  test('longestCommonSubsequenceIndexes', () {
    expect(
      longestCommonSubsequenceIndexes(<String>[], <String>[]),
      equals(<String>[]),
    );
    expect(
      longestCommonSubsequenceIndexes(
        <String>["1", "2", "3", "4", "5"],
        <String>["3", "5"],
      ),
      equals(<int>[2, 4]),
    );
    expect(
      longestCommonSubsequenceIndexes(
        <String>['h', 'e', 'l', 'l', 'o'],
        <String>['h', 'o', 'l', 'l', 'a'],
      ),
      equals(<int>[0, 2, 3]),
    );
    expect(
      longestCommonSubsequenceIndexes(
        <String>['h', 'o', 'w', ',', 'a', 'r', 'e', 'y', 'o', 'u'],
        <String>['h', 'o', 'y', 'u', 'a'],
      ),
      equals(<int>[0, 1, 3, 7, 9]),
    );

    expect(
      longestCommonSubsequenceIndexes(
        <String>['h', 'e', ' ', 'l', 'o'],
        <String>['h', 'o', 'l', 'l', 'a'],
      ),
      equals(<int>[0, 2, 4]),
    );
    expect(
      longestCommonSubsequenceIndexes(
        <String>['h', 'e', ' ', 'l', 'o', '。'],
        <String>['h', 'o', 'l', 'l', 'a'],
      ),
      equals(<int>[0, 2, 4, 5]),
    );
  });

  test('FindIndexWithSymbol', () {
    expect(
      findIndexWithSymbol('#昨日#は雨だったのに、今日は晴れです。', '#'),
      equals(<int>[0, 1]),
    );

    expect(findIndexWithSymbol('昨日は雨だったのに、今日は晴れです。', '#'), equals(<int>[]));
    expect(findIndexWithSymbol('昨日は#雨#だったのに、今日は晴れです。', '#'), equals(<int>[3]));
    expect(findIndexWithSymbol('昨日は雨だったのに、今日は晴れです。#', '#'), equals(<int>[]));
    expect(findIndexWithSymbol('#昨日', '#'), equals(<int>[0, 1]));
    expect(findIndexWithSymbol('#昨##日', '#'), equals(<int>[0, 1]));
    expect(findIndexWithSymbol('#昨##日#', '#'), equals(<int>[0, 1]));
    expect(
      findIndexWithSymbol('#昨日%#', '#', ignoreSymbol: '%'),
      equals(<int>[0, 1]),
    );
    expect(findIndexWithSymbol('#%#', '#', ignoreSymbol: '%'), equals(<int>[]));
    expect(findIndexWithSymbol('#', '#', ignoreSymbol: '%'), equals(<int>[]));
    expect(findIndexWithSymbol('##', '#', ignoreSymbol: '%'), equals(<int>[]));
    try {
      findIndexWithSymbol('#昨日#', '#', ignoreSymbol: '#');
    } catch (e) {
      expect(e, isA<AssertionError>());
    }

    expect(
      findIndexWithSymbol('自分の#経験#について%話してもいいですか%。', '#', ignoreSymbol: '%'),
      equals(<int>[3, 4]),
    );

    expect(
      findIndexWithSymbol('自分の#経験#について%話してもいいですか%。', '%', ignoreSymbol: '#'),
      equals(<int>[9, 10, 11, 12, 13, 14, 15, 16, 17]),
    );

    expect(
      findIndexWithSymbol('自分の#経験#について%話してもいいですか%。', '%', ignoreSymbol: ''),
      equals(<int>[11, 12, 13, 14, 15, 16, 17, 18, 19]),
    );
  });
}
