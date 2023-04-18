import 'package:flutter/material.dart';

class LearningModeSwitch extends StatefulWidget {
  @override
  _LearningModeSwitchState createState() => _LearningModeSwitchState();
}

class _LearningModeSwitchState extends State<LearningModeSwitch> {
  bool _isManualMode = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Ручной ввод'),
        Switch(
          value: _isManualMode,
          onChanged: (bool value) {
            setState(() {
              _isManualMode = value;
            });
          },
        ),
        Text('Выбор из списка'),
      ],
    );
  }
}
