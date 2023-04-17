import 'package:flutter/material.dart';
import 'package:languageapp/model/word.dart';
import 'package:languageapp/service/dictionary_service.dart';

// Экран добавления слова
class AddScreen extends StatefulWidget {
  // Сервис для работы с данными
  final DictionaryService service;

  const AddScreen({Key? key, required this.service}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // Контроллеры для ввода данных
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _audioController = TextEditingController();

  // Метод для создания нового слова и добавления его в сервис
  void _addWord() {
    String word = _wordController.text;
    String translation = _translationController.text;
    String? image =
        _imageController.text.isEmpty ? null : _imageController.text;
    String? audio =
        _audioController.text.isEmpty ? null : _audioController.text;
    int id = widget.service.readWords().length + 1;
    Word newWord = Word(
      id: id,
      word: word,
      translation: translation,
      image: image,
      audio: audio,
    );
    widget.service.createWord(newWord);
    Navigator.pop(context);
  }

  // Метод для отображения поля ввода данных
  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  // Метод для отображения кнопки добавления слова
  Widget _buildAddButton() {
    return ElevatedButton(
      child: Text('Добавить слово'),
      onPressed: _addWord,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить слово'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputField('Слово', _wordController),
            SizedBox(height: 16.0),
            _buildInputField('Перевод', _translationController),
            SizedBox(height: 16.0),
            _buildInputField('Изображение (ссылка)', _imageController),
            SizedBox(height: 16.0),
            _buildInputField('Аудио (ссылка)', _audioController),
            SizedBox(height: 16.0),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }
}
