import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:languageapp/model/word.dart';
import 'package:languageapp/service/dictionary_service.dart';
import 'package:languageapp/screen/exercise_screen.dart';
import 'package:languageapp/screen/edit_screen.dart';
import 'package:languageapp/screen/add_screen.dart';

// Главный экран
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Сервис для работы с данными
  final DictionaryService _service = DictionaryService();

  // Список всех слов
  List<Word> _words = [];

  // Объект AudioPlayer для воспроизведения аудио
  final player = AudioPlayer();

  // Метод для получения всех слов при инициализации экрана
  @override
  void initState() {
    super.initState();
    _words = _service.readWords();
  }

  // Метод для обновления списка слов при изменении данных
  void _updateWords() {
    setState(() {
      _words = _service.readWords();
    });
  }

  // Метод для перехода к экрану добавления слова
  void _navigateToAddScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddScreen(service: _service)),
    );
    _updateWords();
  }

  // Метод для перехода к экрану редактирования слова
  void _navigateToEditScreen(Word word) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditScreen(service: _service, word: word)),
    );
    _updateWords();
  }

  // Метод для перехода к экрану упражнения
  void _navigateToExerciseScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExerciseScreen(service: _service)),
    );
    _updateWords();
  }

  // Метод для удаления слова по свайпу
  void _deleteWord(Word word) {
    setState(() {
      _service.deleteWord(word.id);
      _words.remove(word);
    });
  }

  // Метод для отображения элемента списка слов
  Widget _buildWordItem(Word word) {
    return Dismissible(
      key: Key(word.id.toString()),
      onDismissed: (direction) => _deleteWord(word),
      background: Container(color: Colors.red),
      child: ListTile(
        title: Text(word.word),
        subtitle: Text(word.translation),
        leading: word.image != null ? Image.network(word.image!) : null,
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _navigateToEditScreen(word),
        ),
        onTap: () => _playAudio(word.audio),
      ),
    );
  }

  // Метод для воспроизведения аудио по ссылке
  void _playAudio(String? url) {
    if (url != null) {
      // Загружаем аудио по ссылке
      player.setUrl(url).then((_) {
        // Воспроизводим аудио
        player.play();
      }).catchError((error) {
        // Обрабатываем ошибку
        print(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Словарь'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddScreen,
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: _navigateToExerciseScreen,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _words.length,
        itemBuilder: (context, index) {
          return _buildWordItem(_words[index]);
        },
      ),
    );
  }
}
