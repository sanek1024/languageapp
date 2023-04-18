import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/word.dart';

class DictionaryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Word>> getWords(String dictionaryId) async {
    final snapshot = await _firestore
        .collection('dictionaries')
        .doc(dictionaryId)
        .collection('words')
        .get();
    final List<Word> words = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data();
      final word = Word(
        id: doc.id,
        text: data['text'],
        translation: data['translation'],
      );
      words.add(word);
    });

    return words;
  }

  Future<void> addWord(String dictionaryId, Word word) async {
    await _firestore
        .collection('dictionaries')
        .doc(dictionaryId)
        .collection('words')
        .add({
      'text': word.text,
      'translation': word.translation,
    });
  }

  Future<void> updateWord(String dictionaryId, Word word) async {
    await _firestore
        .collection('dictionaries')
        .doc(dictionaryId)
        .collection('words')
        .doc(word.id)
        .update({
      'text': word.text,
      'translation': word.translation,
    });
  }

  Future<void> deleteWord(String dictionaryId, String wordId) async {
    await _firestore
        .collection('dictionaries')
        .doc(dictionaryId)
        .collection('words')
        .doc(wordId)
        .delete();
  }
}
