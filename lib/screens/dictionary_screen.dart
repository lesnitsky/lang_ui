import 'package:flutter/material.dart';
import 'package:lang_ui/localstorage.dart';
import 'package:lang_ui/entities.dart' show Word;

import './word_screen.dart';

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
  List<Word> words;
  @override
  void initState() {
    words = getWords(widget.langId);
    super.initState();
  }

  _addWord() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext conext) {
      return WordScreen(word: new Word());
    }));

    if (result == null) {
      return;
    }

    words.add(result);

    _persist();
  }

  _editWord(Word word, int index) async {
    final result = await Navigator.of(context).push<Word>(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return WordScreen(word: word);
        },
      ),
    );

    if (result == null) {
      return;
    }

    setState(() {
      words[index] = result;
    });

    _persist();
  }

  _persist() {
    localStorage.setItem(
      widget.langId,
      List.from(words.map(
        (w) => w.toJson(),
      )),
    );
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
          final word = words[index];

          return InkWell(
            child: ListTile(
              title: Text(word.text),
            ),
            onTap: () {
              _editWord(word, index);
            },
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
