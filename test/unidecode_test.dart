import 'package:unidecode/unidecode.dart';
import 'package:test/test.dart';

void testOutput(Map<String, String> inputsToExpected) {
  final converter = UniDecode();
  inputsToExpected.forEach((input, expected) {
    test(input, () {
      expect(converter.convert(input), expected);
    });
  });
}

const specifics = {
  "Tōkyō": "Tokyo",
  'Hello, World!': "Hello, World!",
  '\'"\r\n': "'\"\r\n",
  'ČŽŠčžš': "CZSczs",
  'ア': "a",
  'α': "a",
  'а': "a",
  'ch\u00e2teau': "chateau",
  'vi\u00f1edos': "vinedos",
  '\u5317\u4EB0': "Bei Jing ",
  'Efﬁcient': "Efficient",
  'příliš žluťoučký kůň pěl ďábelské ódy':
      'prilis zlutoucky kun pel dabelske ody',
  'PŘÍLIŠ ŽLUŤOUČKÝ KŮŇ PĚL ĎÁBELSKÉ ÓDY':
      'PRILIS ZLUTOUCKY KUN PEL DABELSKE ODY',
};

void main() {
  group("specifics", () => testOutput(specifics));
}
