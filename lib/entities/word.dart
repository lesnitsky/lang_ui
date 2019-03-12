// TODO: use json_annotation

class Word {
  String text;
  List<String> translations;

  Word({this.text, this.translations}) {
    translations ??= [];
  }

  toJson() {
    return {
      'text': text,
      'translations': translations,
    };
  }

  static fromJson(dynamic data) {
    return Word(
      text: data['text'],
      translations: List.from(data['translations']),
    );
  }
}
