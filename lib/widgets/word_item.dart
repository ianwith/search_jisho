import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/word.dart';
import '../model/saved_words_model.dart';
import '../screens/details.dart';
import '../widgets/save_button.dart';

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
    String definitionStr= word.senses.map((s) => s.englishDefinitions.join(', ')).join('; ');
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
      String jaWord = japanese.word ?? '';
      String jaReading = japanese.reading != null ? '【${japanese.reading}】' : '';
      japaneseStr += jaWord + jaReading;
    }
    return Text(japaneseStr);
  }

  @override
  Widget build(BuildContext context) {
    final SavedWordsModel model = Provider.of<SavedWordsModel>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => Details(word: word),
          )
        );
      },
      child: Padding(
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
                  child: SaveButton(
                    saved: saved,
                    onPressed: () {
                      saved ? model.remove(word) : model.add(word);
                    },
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
        ),
      ),
    );
  }
}
