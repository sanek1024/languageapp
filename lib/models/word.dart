class Word {
  String id;
  String text;
  String translation;
  int correctAnswers;
  int wrongAnswers;
  double weight;
  bool isLearned;
  bool isUnknown;

  Word({
    this.id = '',
    required this.text,
    required this.translation,
    this.correctAnswers = 0,
    this.wrongAnswers = 0,
    this.weight = 1.0,
    this.isLearned = false,
    this.isUnknown = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'translation': translation,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'weight': weight,
      'isLearned': isLearned,
      'isUnknown': isUnknown,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map, String id) {
    return Word(
      id: id,
      text: map['text'],
      translation: map['translation'],
      correctAnswers: map['correctAnswers'],
      wrongAnswers: map['wrongAnswers'],
      weight: map['weight'],
      isLearned: map['isLearned'],
      isUnknown: map['isUnknown'],
    );
  }
}
