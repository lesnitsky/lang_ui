// TODO: use json_annotation

class Word {
  String text;
  List<String> translations;

  Word({this.text, this.translations}) {
    translations ??= [''];
  }

  toJson() {
    return {
      'text': text,
      'translations': translations,
    };
  }

  static Word fromJson(dynamic data) {
    return Word(
      text: data['text'],
      translations: List.from(data['translations']),
    );
  }

  clone() {
    return fromJson(toJson());
  }

  isValid() {
    return text != null &&
        text.length > 0 &&
        translations.length > 0 &&
        !translations.any((t) => t == null || t.length == 0);
  }
}
