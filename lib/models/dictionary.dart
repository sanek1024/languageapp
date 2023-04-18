import '../models/word.dart';
import '../services/database.dart';

class Dictionary {
  String name;
  String sourceLanguage;
  String targetLanguage;
  List<Word>? words;
  String id;

  Dictionary({
    required this.name,
    required this.sourceLanguage,
    required this.targetLanguage,
    this.words,
    required this.id,
  });

  static Future<List<Dictionary>> getDictionaries() async {
    return await Database.getDictionaries();
  }

  static Future<void> addDictionary(Dictionary dictionary) async {
    await Database.addDictionary(dictionary);
  }

  static Future<void> updateDictionary(Dictionary dictionary) async {
    await Database.updateDictionary(dictionary);
  }

  static Future<void> deleteDictionary(String id) async {
    await Database.deleteDictionary(id);
  }

  static Dictionary fromMap(Map<String, dynamic> map, String id) {
    return Dictionary(
      name: map['name'],
      sourceLanguage: map['sourceLanguage'],
      targetLanguage: map['targetLanguage'],
      words: map['words'] != null
          ? List<Word>.from(
              map['words']!.map((word) => Word.fromMap(word, word['id'])))
          : [],
      id: id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sourceLanguage': sourceLanguage,
      'targetLanguage': targetLanguage,
      'words': words?.map((word) => word.toMap()).toList(),
    };
  }

  void addWord(Word word) {
    if (words != null) {
      words!.add(word);
    } else {
      words = [word];
    }
  }

  void removeWord(Word word) {
    if (words != null) {
      words!.remove(word);
    }
  }
}
