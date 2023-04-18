import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Слово'),
            SizedBox(height: 10),
            Text('Перевод слова'),
          ],
        ),
      ),
    );
  }
}
