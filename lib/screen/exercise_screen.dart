import 'package:flutter/material.dart';
import 'package:languageapp/model/word.dart';
import 'package:languageapp/service/dictionary_service.dart';
import 'package:languageapp/screen/result_screen.dart';

// Экран упражнения
class ExerciseScreen extends StatefulWidget {
  // Сервис для работы с данными
  final DictionaryService service;

  const ExerciseScreen({Key? key, required this.service}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  // Случайное слово для упражнения
  Word? _word;

  // Список вариантов перевода
  List<Word> _options = [];

  // Метод для получения случайного слова и вариантов перевода при инициализации экрана
  @override
  void initState() {
    super.initState();
    _getRandomWordAndOptions();
  }

  // Метод для получения случайного слова и вариантов перевода
  void _getRandomWordAndOptions() {
    setState(() {
      _word = widget.service.getRandomWords(1).first;
      _options = widget.service.getRandomWords(4);
      if (!_options.contains(_word)) {
        _options[0] = _word!;
      }
      _options.shuffle();
    });
  }

  // Метод для перехода к экрану результата
  void _navigateToResultScreen(Word option) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResultScreen(
              service: widget.service, word: _word!, option: option)),
    );
    _getRandomWordAndOptions();
  }

  // Метод для отображения слова для упражнения
  Widget _buildWord() {
    return Text(
      _word!.word,
      style: TextStyle(fontSize: 32.0),
    );
  }

  // Метод для отображения варианта перевода
  Widget _buildOption(Word option) {
    return ListTile(
      title: Text(option.translation),
      onTap: () => _navigateToResultScreen(option),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Упражнение'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWord(),
            SizedBox(height: 32.0),
            ..._options.map((option) => _buildOption(option)).toList(),
          ],
        ),
      ),
    );
  }
}
