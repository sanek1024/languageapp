import 'package:flutter/material.dart';
import 'package:languageapp/model/word.dart';
import 'package:languageapp/service/dictionary_service.dart';

// Экран редактирования слова
class EditScreen extends StatefulWidget {
  // Сервис для работы с данными
  final DictionaryService service;

  // Слово для редактирования
  final Word word;

  const EditScreen({Key? key, required this.service, required this.word})
      : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  // Контроллеры для ввода данных
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _audioController = TextEditingController();

  // Метод для инициализации контроллеров данными слова
  @override
  void initState() {
    super.initState();
    _wordController.text = widget.word.word;
    _translationController.text = widget.word.translation;
    _imageController.text = widget.word.image ?? '';
    _audioController.text = widget.word.audio ?? '';
  }

  // Метод для обновления слова и сохранения его в сервисе
  void _updateWord() {
    String word = _wordController.text;
    String translation = _translationController.text;
    String? image =
        _imageController.text.isEmpty ? null : _imageController.text;
    String? audio =
        _audioController.text.isEmpty ? null : _audioController.text;
    widget.service.updateWord(
      widget.word.id,
      word: word,
      translation: translation,
      image: image,
      audio: audio,
    );
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

  // Метод для отображения кнопки обновления слова
  Widget _buildUpdateButton() {
    return ElevatedButton(
      child: Text('Обновить слово'),
      onPressed: _updateWord,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать слово'),
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
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }
}
