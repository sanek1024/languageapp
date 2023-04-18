import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dictionary.dart';

class Database {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> dictionariesRef =
      firestore.collection('dictionaries');

  static Future<List<Dictionary>> getDictionaries() async {
    var snapshot = await dictionariesRef.get();
    return snapshot.docs
        .map((doc) =>
            Dictionary.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  static Future<void> addDictionary(Dictionary dictionary) async {
    await dictionariesRef.add(dictionary.toMap());
  }

  static Future<void> updateDictionary(Dictionary dictionary) async {
    await dictionariesRef.doc(dictionary.id).update(dictionary.toMap());
  }

  static Future<void> deleteDictionary(String id) async {
    await dictionariesRef.doc(id).delete();
  }
}
