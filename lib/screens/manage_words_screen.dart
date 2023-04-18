import 'package:flutter/material.dart';
import '../models/word.dart';
import '../services/dictionary_service.dart';
import '../screens/edit_word_screen.dart';
import '../screens/add_word_screen.dart';

class ManageWordsScreen extends StatefulWidget {
  final String dictionaryId;

  ManageWordsScreen({required this.dictionaryId});

  @override
  _ManageWordsScreenState createState() => _ManageWordsScreenState();
}

class _ManageWordsScreenState extends State<ManageWordsScreen> {
  final DictionaryService _dictionaryService = DictionaryService();
  List<Word> _words = [];

  void _getWords() async {
    List<Word> words = await _dictionaryService.getWords(widget.dictionaryId);
    setState(() {
      _words = words;
    });
  }

  void _addWord() async {
    final newWord = await Navigator.pushNamed(context, '/add_word',
        arguments: widget.dictionaryId);
    if (newWord != null && newWord is Word) {
      await _dictionaryService.addWord(widget.dictionaryId, newWord);
      _getWords();
    }
  }

  void _editWord(Word word) async {
    final editedWord =
        await Navigator.pushNamed(context, '/edit_word', arguments: word);
    if (editedWord != null && editedWord is Word) {
      await _dictionaryService.updateWord(widget.dictionaryId, editedWord);
      _getWords();
    }
  }

  void _deleteWord(Word word) async {
    await _dictionaryService.deleteWord(widget.dictionaryId, word.id!);
    _getWords();
  }

  @override
  void initState() {
    super.initState();
    _getWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Words'),
      ),
      body: ListView.builder(
        itemCount: _words.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_words[index].text),
            subtitle: Text(_words[index].translation),
            onTap: () => _editWord(_words[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteWord(_words[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWord,
        child: Icon(Icons.add),
      ),
    );
  }
}
