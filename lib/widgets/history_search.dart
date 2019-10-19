import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/searched_keywords_model.dart';

class HistorySearch extends StatelessWidget {
  HistorySearch({ @required this.onKeywordTap });

  final ValueChanged<String> onKeywordTap;

  @override
  Widget build(BuildContext context) {
    final SearchedKeywordsModel model =
        Provider.of<SearchedKeywordsModel>(context);
    final List<String> items = model.items;
    final int total = model.total;
    return ListView.builder(
      itemBuilder: (context, index) {
        String item = items[index];
        return Dismissible(
          key: Key(item),
          child: GestureDetector(
            onTap: () {
              onKeywordTap(item);
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 20),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Text(item),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Container(
                        height: 1,
                        color: Color(0xFFD9D9D9),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          background: Container(
            color: Color(0xFFF44336),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 15.0),
            child: Text(
              'Swipe to delete',
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
            ),
          ),
          onDismissed: (direction) {
            model.remove(item);
          },
        );
      },
      itemCount: total,
    );
  }
}
