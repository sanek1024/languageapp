import '../models/word.dart';

class LearningService {
  Word getNextWord() {
    // Ваша логика для получения следующего слова для изучения
    return Word(text: 'example', translation: 'пример');
  }

  bool checkAnswer(Word word, String answer) {
    // Ваша логика для проверки правильности ответа пользователя
    return word.translation == answer;
  }
}
