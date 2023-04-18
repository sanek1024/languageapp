import 'package:flutter/material.dart';
import '../models/dictionary.dart';

class EditDictionaryScreen extends StatefulWidget {
  final Dictionary dictionary;

  EditDictionaryScreen({required this.dictionary});

  @override
  _EditDictionaryScreenState createState() => _EditDictionaryScreenState();
}

class _EditDictionaryScreenState extends State<EditDictionaryScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  @override
  void initState() {
    super.initState();
    _name = widget.dictionary.name;
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.dictionary.name = _name;
      Navigator.pop(context, widget.dictionary);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Dictionary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _name,
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
                  ElevatedButton(
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
