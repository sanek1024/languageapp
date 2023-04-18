import 'package:flutter/material.dart';
import '../models/dictionary.dart';
import '../models/word.dart';

class AddWordScreen extends StatefulWidget {
  final Dictionary dictionary;

  AddWordScreen({required this.dictionary});

  @override
  _AddWordScreenState createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _translationController = TextEditingController();

  void _saveWord() {
    final text = _textController.text.trim();
    final translation = _translationController.text.trim();

    if (text.isNotEmpty && translation.isNotEmpty) {
      final word = Word(text: text, translation: translation);
      widget.dictionary.addWord(word);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Word'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(labelText: 'Word'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a word';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _translationController,
                decoration: InputDecoration(labelText: 'Translation'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a translation';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveWord();
                      }
                    },
                    child: Text('Save'),
                  ),
                  SizedBox(width: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
