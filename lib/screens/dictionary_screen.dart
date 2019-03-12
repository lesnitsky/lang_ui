import 'package:flutter/material.dart';
import 'package:lang_ui/localstorage.dart';

class DictionaryScreen extends StatelessWidget {
  final String langId;

  DictionaryScreen({this.langId});

  @override
  Widget build(BuildContext context) {
    return DictionaryScreenContent(langId: langId);
  }
}

class DictionaryScreenContent extends StatefulWidget {
  final String langId;

  DictionaryScreenContent({this.langId});
  @override
  _DictionaryScreenContentState createState() =>
      _DictionaryScreenContentState();
}

class _DictionaryScreenContentState extends State<DictionaryScreenContent> {
  List<String> words;
  @override
  void initState() {
    final _words = localStorage.getItem(widget.langId) ?? [];

    words = List.from(_words);
    super.initState();
  }

  _addWord() async {
    print('add word');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dictionary'),
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          final word = words[index].split(',')[0];

          return ListTile(
            title: Text(word),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addWord,
      ),
    );
  }
}
