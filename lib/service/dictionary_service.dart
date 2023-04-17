import 'dart:math';
import 'package:languageapp/model/word.dart';

class DictionaryService {
  // Список слов
  List<Word> _words = [];

  // Создает новое слово и добавляет его в список
  void createWord(Word word) {
    _words.add(word);
  }

  // Возвращает список всех слов
  List<Word> readWords() {
    return _words;
  }

  // Обновляет поля слова по его id
  void updateWord(int id,
      {String? word,
      String? translation,
      String? image,
      String? audio,
      int? correct,
      int? wrong,
      int? weight}) {
    Word oldWord = _words.firstWhere((word) => word.id == id);
    Word newWord = Word(
      id: oldWord.id,
      word: word ?? oldWord.word,
      translation: translation ?? oldWord.translation,
      image: image ?? oldWord.image,
      audio: audio ?? oldWord.audio,
      correct: correct ?? oldWord.correct,
      wrong: wrong ?? oldWord.wrong,
      weight: weight ?? oldWord.weight,
    );
    int index = _words.indexOf(oldWord);
    _words[index] = newWord;
  }

  // Удаляет слово по его id
  void deleteWord(int id) {
    _words.removeWhere((word) => word.id == id);
  }

  // Возвращает список случайных слов для упражнений
  List<Word> getRandomWords(int count) {
    List<Word> randomWords = [];
    Random random = Random();
    while (randomWords.length < count) {
      int index = random.nextInt(_words.length);
      Word word = _words[index];
      if (!randomWords.contains(word)) {
        randomWords.add(word);
      }
    }
    return randomWords;
  }

  // Проверяет ответ пользователя и возвращает true или false
  bool checkAnswer(int id, String answer) {
    Word word = _words.firstWhere((word) => word.id == id);
    return word.translation == answer;
  }
}
