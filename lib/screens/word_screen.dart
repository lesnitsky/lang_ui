import 'package:flutter/material.dart';
import 'package:lang_ui/entities.dart' show Word;

class WordScreen extends StatelessWidget {
  WordScreen({this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    return WordScreenContent(word: word);
  }
}

class WordScreenContent extends StatefulWidget {
  WordScreenContent({this.word});
  final Word word;
  @override
  _WordScreenContentState createState() => _WordScreenContentState();
}

class _WordScreenContentState extends State<WordScreenContent> {
  Word word;
  TextEditingController wordController;
  List<TextEditingController> translationControllers;

  @override
  void initState() {
    word = widget.word.clone();
    wordController = new TextEditingController();

    _generateControllers();
    _bindControllerListeners();

    wordController.text = word.text;

    super.initState();
  }

  _generateControllers() {
    translationControllers = List.generate(
      word.translations.length,
      (index) => new TextEditingController(text: word.translations[index]),
    );
  }

  _addTranslation() {
    setState(() {
      word.translations.add('');
      translationControllers.add(new TextEditingController());

      _bindControllerListeners();
    });
  }

  _bindControllerListeners() {
    wordController.addListener(() {
      word.text = wordController.text;
      _update();
    });

    translationControllers.asMap().forEach((index, controller) {
      if (controller.hasListeners) {
        return;
      }

      controller.addListener(() {
        word.translations[index] = controller.text;
        _update();
      });
    });
  }

  _update() {
    setState(() {});
  }

  _deleteTranslation(int index) {
    setState(() {
      word.translations.removeAt(index);
      translationControllers[index].removeListener(_update);
      translationControllers.removeAt(index);
    });
  }

  _buildTranslationInputs() {
    return word.translations
        .asMap()
        .map((int index, String translation) {
          return MapEntry(
            index,
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextField(
                      autofocus: false,
                      controller: translationControllers[index],
                      decoration: InputDecoration(labelText: 'Translation'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteTranslation(index);
                    },
                  ),
                ],
              ),
            ),
          );
        })
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Word'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                autofocus: false,
                controller: wordController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Translations', style: textTheme.headline),
            ),
          ]
            ..addAll(_buildTranslationInputs())
            ..add(FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.add),
                  Text('Add translation'),
                ],
              ),
              onPressed: _addTranslation,
            ))
            ..toList(),
        ),
      ),
      floatingActionButton: word.isValid()
          ? FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop(word);
              },
            )
          : null,
    );
  }
}
