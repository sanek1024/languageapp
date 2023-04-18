import 'package:flutter/material.dart';
import '../models/word.dart';
import '../widgets/learning_mode_switch.dart';
import '../services/learning_service.dart';

class LearnScreen extends StatefulWidget {
  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  LearningService _learningService = LearningService();
  late Word _currentWord;

  @override
  void initState() {
    super.initState();
    _currentWord = _learningService.getNextWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn words'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentWord.text,
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(height: 20),
            LearningModeSwitch(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentWord = _learningService.getNextWord();
                });
              },
              child: Text('Next word'),
            ),
          ],
        ),
      ),
    );
  }
}
