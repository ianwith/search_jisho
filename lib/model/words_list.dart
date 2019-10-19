import 'word.dart';

class WordsList {
  final List<Word> data;

  WordsList({
    this.data
  });

  WordsList.fromJSON(Map<String, dynamic> json)
      : data = (json['data'] as List).map((d) => Word.fromJSON(d)).toList();
}
