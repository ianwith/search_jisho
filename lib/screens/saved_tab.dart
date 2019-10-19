import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

import '../widgets/word_item.dart';
import '../model/saved_words_model.dart';
import '../model/word.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SavedWordsModel>(
      builder: (context, model, child) {
        return FutureBuilder(
          future: model.items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Word> items = snapshot.data;
              int total = items.length;
              return CustomScrollView(
                slivers: <Widget>[
                  CupertinoSliverNavigationBar(
                    largeTitle: Text('Saved Words'),
                  ),
                  total == 0
                      ? SliverToBoxAdapter(
                          child: SizedBox(
                            height: 500,
                            child: Center(
                              child: Text('You have not saved any word yet:('),
                            ),
                          ),
                        )
                      : SliverSafeArea(
                          top: false,
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index < total) {
                                  return Dismissible(
                                    key: Key(items[index].slug),
                                    background: Container(
                                      color: Color(0xFFF44336),
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Text(
                                        'Swipe to delete',
                                        style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14)
                                      ),
                                    ),
                                    confirmDismiss: (direction) async {
                                      // async here
                                      // returned Future completes true, then this widget will be dismissed
                                      await model.remove(items[index]);
                                      return true;
                                    },
                                    child: WordItem(
                                      index: index,
                                      word: items[index],
                                    ),
                                  );
                                } else {
                                  return null;
                                }
                              }
                            ),
                          ),
                        ),
                ],
              );
            }
            return Center(child: Text('loading shared preferences'));
          },
        );
      },
    );
  }
}
