import 'package:flutter/material.dart';
import 'package:lang_ui/localstorage.dart';

import 'package:lang_ui/screens.dart' show MainScreen;

void main() async {
  await localStorage.ready;
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(
        languageName: 'English',
        langId: 'en',
      ),
    );
  }
}
