import '../models/word.dart';

List<Word> sortWordsAlphabetically(List<Word> words) {
  words.sort((a, b) => a.text.compareTo(b.text));
  return words;
}
