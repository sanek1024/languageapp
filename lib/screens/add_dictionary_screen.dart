import 'package:flutter/material.dart';
import '../models/dictionary.dart';

class AddDictionaryScreen extends StatefulWidget {
  @override
  _AddDictionaryScreenState createState() => _AddDictionaryScreenState();
}

class _AddDictionaryScreenState extends State<AddDictionaryScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Dictionary newDictionary = Dictionary(
        name: _name,
        sourceLanguage: '',
        targetLanguage: '',
        words: [],
        id: '',
      );
      Navigator.pop(context, newDictionary);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dictionary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Dictionary Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _save,
                    child: Text('Save'),
                  ),
                  TextButton(
                    onPressed: _cancel,
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
