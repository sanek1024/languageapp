import 'package:flutter/material.dart';
import '../models/word.dart';

class EditWordScreen extends StatefulWidget {
  final Word word;

  EditWordScreen({required this.word});

  @override
  _EditWordScreenState createState() => _EditWordScreenState();
}

class _EditWordScreenState extends State<EditWordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _text = '';
  String _translation = '';

  @override
  void initState() {
    super.initState();
    _text = widget.word.text;
    _translation = widget.word.translation;
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context,
          Word(id: widget.word.id, text: _text, translation: _translation));
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Word'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Word'),
                initialValue: widget.word.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a word';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => _text = value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Translation'),
                initialValue: widget.word.translation,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a translation';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => _translation = value),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _save,
                    child: Text('Save'),
                    style: TextButton.styleFrom(primary: Colors.blue),
                  ),
                  TextButton(
                    onPressed: _cancel,
                    child: Text('Cancel'),
                    style: TextButton.styleFrom(primary: Colors.blue),
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
