import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/manage_dictionaries_screen.dart';
import 'screens/manage_words_screen.dart';
import 'screens/add_dictionary_screen.dart';
import 'screens/edit_dictionary_screen.dart';
import 'screens/add_word_screen.dart';
import 'screens/edit_word_screen.dart';
import 'models/dictionary.dart';
import 'models/word.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/learn': (context) => LearnScreen(),
        '/manage_dictionaries': (context) =>
            ManageDictionariesScreen(onDictionarySelected: (dictionary) {
              Navigator.pushNamed(context, '/manage_words',
                  arguments: dictionary.id);
            }),
        '/manage_words': (context) => ManageWordsScreen(
              dictionaryId:
                  ModalRoute.of(context)!.settings.arguments as String,
            ),
        '/add_dictionary': (context) => AddDictionaryScreen(),
        '/edit_dictionary': (context) => EditDictionaryScreen(
              dictionary:
                  ModalRoute.of(context)!.settings.arguments as Dictionary,
            ),
        '/add_word': (context) => AddWordScreen(
              dictionary:
                  ModalRoute.of(context)!.settings.arguments as Dictionary,
            ),
        '/edit_word': (context) => EditWordScreen(
              word: ModalRoute.of(context)!.settings.arguments as Word,
            ),
      },
    );
  }
}
