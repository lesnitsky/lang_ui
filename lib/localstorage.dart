import 'package:localstorage/localstorage.dart';
import 'package:lang_ui/entities.dart' show Word;

final localStorage = new LocalStorage('lang-ui');

List<Word> getWords(String key) {
  final _words = localStorage.getItem(key) ?? [];

  final words =
      (_words as List).map<Word>((word) => Word.fromJson(word)).toList();

  return words;
}
