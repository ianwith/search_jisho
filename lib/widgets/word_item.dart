import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/word.dart';
import '../model/saved_words_model.dart';

const TextStyle definitionsText = TextStyle(
  color: Color.fromRGBO(0, 0, 0, 1),
  fontSize: 15,
);

class WordItem extends StatelessWidget {
  WordItem({ this.index, this.word, this.showButton = false, this.saved = false });

  final int index;
  final Word word;
  final bool showButton;
  final bool saved;

  Widget _buildEnglishDefinitions() {
    String definitionStr = '';
    List<SenseItem> senses = word.senses;
    for (int i = 0; i < senses.length; i++) {
      List<String> definitions = senses[i].englishDefinitions;
      for (int i = 0; i < definitions.length; i++) {
        definitionStr += definitions[i];
        if (i != definitions.length - 1) {
          definitionStr += ', ';
        }
      }
      if (i != senses.length - 1) {
        definitionStr += '; ';
      }
    }
    return Text(
      definitionStr,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: definitionsText
    );
  }

  Widget _buildJapanese() {
    String japaneseStr = '';
    for (JapaneseItem japanese in word.japanese) {
      japaneseStr += japanese.word != null ? japanese.word : '';
      japaneseStr += japanese.reading != null ? '【' + japanese.reading + '】' : '';
    }
    return Text(japaneseStr);
  }

  @override
  Widget build(BuildContext context) {
    final SavedWordsModel model = Provider.of<SavedWordsModel>(context);
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildJapanese(),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildEnglishDefinitions(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                  ],
                ),
              ),
              Visibility(
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  onPressed: () {
                    saved ? model.remove(word) : model.add(word);
                  },
                  child: saved
                      ? Icon(CupertinoIcons.heart_solid)
                      : Icon(CupertinoIcons.heart),
                ),
                visible: showButton,
              ),
            ],
          ),
          Container(
            height: 1,
            color: Color(0xFFD9D9D9),
          ),
        ],
      )
    );
  }
}
