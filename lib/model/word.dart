class Word {
  final String slug;
  final List<JapaneseItem> japanese;
  final List<SenseItem> senses;

  Word({
    this.slug,
    this.japanese,
    this.senses
  });

  Word.fromJSON(Map<String, dynamic> json)
      : slug = json['slug'],
        japanese = (json['japanese'] as List)
            .map((j) => JapaneseItem.fromJSON(j))
            .toList(),
        senses =
            (json['senses'] as List).map((s) => SenseItem.fromJSON(s)).toList();

  Map<String, dynamic> toJSON() => {
        'slug': slug,
        'japanese': japanese.map((jp) => jp.toJSON()).toList(),
        'senses': senses.map((se) => se.toJSON()).toList()
      };
}

class JapaneseItem {
  final String word;
  final String reading;

  JapaneseItem({
    this.word,
    this.reading
  });

  JapaneseItem.fromJSON(Map<String, dynamic> json)
      : word = json['word'],
        reading = json['reading'];

  Map<String, String> toJSON() => {
    'word': word,
    'reading': reading
  };
}

class SenseItem {
  final List<String> englishDefinitions;
  final List<String> partsOfSpeech;

  SenseItem({
    this.englishDefinitions,
    this.partsOfSpeech,
  });

  SenseItem.fromJSON(Map<String, dynamic> json)
      : englishDefinitions = new List<String>.from(json['english_definitions']),
        partsOfSpeech = new List<String>.from(json['parts_of_speech']);

  Map<String, dynamic> toJSON() => {
    'english_definitions': englishDefinitions,
    'parts_of_speech': partsOfSpeech,
  };
}
