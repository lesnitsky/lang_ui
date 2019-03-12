import 'package:flutter/material.dart';
import './dictionary_screen.dart';
import './time_attack_screen.dart';

class MainScreen extends StatelessWidget {
  final String languageName;
  final String langId;

  MainScreen({this.languageName, this.langId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(languageName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return DictionaryScreen(langId: langId);
                }));
              },
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text('Dictionary'),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return TimeAttackScreen();
                }));
              },
              child: ListTile(
                leading: Icon(Icons.timer),
                title: Text('Pracitce'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
