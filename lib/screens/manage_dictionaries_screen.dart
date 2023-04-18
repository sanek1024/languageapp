import 'package:flutter/material.dart';
import '../models/dictionary.dart';
import '../screens/add_dictionary_screen.dart';
import '../screens/edit_dictionary_screen.dart';

class ManageDictionariesScreen extends StatefulWidget {
  final Function(Dictionary)? onDictionarySelected;

  const ManageDictionariesScreen({Key? key, this.onDictionarySelected})
      : super(key: key);

  @override
  _ManageDictionariesScreenState createState() =>
      _ManageDictionariesScreenState();
}

class _ManageDictionariesScreenState extends State<ManageDictionariesScreen> {
  List<Dictionary> _dictionaries = [];

  void _loadDictionaries() async {
    List<Dictionary> dictionaries = await Dictionary.getDictionaries();
    setState(() {
      _dictionaries = dictionaries;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDictionaries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Dictionaries'),
      ),
      body: ListView.builder(
        itemCount: _dictionaries.length,
        itemBuilder: (context, index) {
          Dictionary dictionary = _dictionaries[index];
          return ListTile(
            title: Text(dictionary.name),
            subtitle: Text('${dictionary.words?.length ?? 0} words'),
            onTap: () {
              if (widget.onDictionarySelected != null) {
                widget.onDictionarySelected!(dictionary);
              } else {
                Navigator.pushNamed(context, '/manage_words',
                    arguments: dictionary.id);
              }
            },
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, '/edit_dictionary',
                    arguments: dictionary);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDictionaryScreen()),
          ).then((_) {
            _loadDictionaries();
          });
        },
        tooltip: 'Add Dictionary',
        child: Icon(Icons.add),
      ),
    );
  }
}
