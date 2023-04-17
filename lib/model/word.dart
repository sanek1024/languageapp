class Word {
  final int id;
  final String word;
  final String translation;
  final String? image;
  final String? audio;
  int correct;
  int wrong;
  int weight;

  Word({
    required this.id,
    required this.word,
    required this.translation,
    this.image,
    this.audio,
    this.correct = 0,
    this.wrong = 0,
    this.weight = 1,
  });
}
