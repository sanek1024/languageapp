import 'package:flutter/widgets.dart';
import 'screens/learn_screen.dart';
import 'screens/manage_dictionaries_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/learn': (BuildContext context) => LearnScreen(),
  '/manage_dictionaries': (BuildContext context) => ManageDictionariesScreen(),
};
