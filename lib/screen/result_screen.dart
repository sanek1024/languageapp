import 'package:flutter/material.dart';
import 'package:languageapp/model/word.dart';
import 'package:languageapp/service/dictionary_service.dart';

// Экран результата
class ResultScreen extends StatefulWidget {
  // Сервис для работы с данными
  final DictionaryService service;

  // Слово для упражнения
  final Word word;

  // Вариант перевода, выбранный пользователем
  final Word option;

  const ResultScreen(
      {Key? key,
      required this.service,
      required this.word,
      required this.option})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // Результат проверки ответа пользователя
  bool _result = false;

  // Метод для проверки ответа пользователя и обновления полей слова при инициализации экрана
  @override
  void initState() {
    super.initState();
    _checkAnswerAndUpdateWord();
  }

  // Метод для проверки ответа пользователя и обновления полей слова
  void _checkAnswerAndUpdateWord() {
    setState(() {
      _result =
          widget.service.checkAnswer(widget.word.id, widget.option.translation);
      int correct = widget.word.correct;
      int wrong = widget.word.wrong;
      int weight = widget.word.weight;
      if (_result) {
        correct++;
        weight--;
      } else {
        wrong++;
        weight++;
      }
      if (weight < 1) {
        weight = 1;
      }
      widget.service.updateWord(
        widget.word.id,
        correct: correct,
        wrong: wrong,
        weight: weight,
      );
    });
  }

  // Метод для отображения результата
  Widget _buildResult() {
    return Text(
      _result ? 'Правильно!' : 'Неправильно!',
      style:
          TextStyle(fontSize: 32.0, color: _result ? Colors.green : Colors.red),
    );
  }

  // Метод для отображения правильного перевода
  Widget _buildCorrectTranslation() {
    return Text(
      'Правильный перевод: ${widget.word.translation}',
      style: TextStyle(fontSize: 24.0),
    );
  }

  // Метод для отображения кнопки продолжения
  Widget _buildContinueButton() {
    return ElevatedButton(
      child: Text('Продолжить'),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результат'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildResult(),
            SizedBox(height: 16.0),
            _buildCorrectTranslation(),
            SizedBox(height: 32.0),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }
}
