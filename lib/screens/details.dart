import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

import '../widgets/save_button.dart';
import '../model/saved_words_model.dart';
import '../model/word.dart';

class Details extends StatelessWidget {
  final Word word;

  Details({
    this.word
  });

  String _getTitle() {
    JapaneseItem ja = word.japanese[0];
    if (ja != null) {
      if (ja.word != null) {
        return ja.word;
      } else {
        return ja.reading;
      }
    } else {
      return '';
    }
  }

  List<Widget> _buildJa() {
    return word.japanese.map(
      (ja) => Text(
          (ja.word ?? '') + (ja.reading != null ? '【${ja.reading}】' : ''),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        )
    ).toList();
  }

  List<Widget> _buildEn() {
    return word.senses.map(
      (se) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (se.partsOfSpeech.length > 0)
            Text(
              '   ' + se.partsOfSpeech.join(', '),
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Color(0xFF9E9E9E),
                height: 1,
              ),
            ),
          Text(
            '- ${se.englishDefinitions.join(", ")}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
        ],
      )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final SavedWordsModel model = Provider.of<SavedWordsModel>(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(_getTitle()),
        trailing: FutureBuilder(
          future: model.items,
          builder: (context, snapshot) {
            bool saved = false;
            if (snapshot.hasData) {
              saved = snapshot.data.indexWhere((item) => item.slug == word.slug) > -1;
            }
            return SaveButton(
              saved: saved,
              onPressed: () {
                saved ? model.remove(word) : model.add(word);
              }
            );
          },
        ),
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              ..._buildJa(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 1,
                color: Color(0xFFD9D9D9),
              ),
              ..._buildEn(),
            ],
          ),
        ),
      ),
    );
  }
}
