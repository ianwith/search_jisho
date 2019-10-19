import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

import '../widgets/search_bar.dart';
import '../widgets/word_item.dart';
import '../widgets/history_search.dart';
import '../model/words_list.dart';
import '../model/word.dart';
import '../model/fetch_words_list.dart';
import '../model/saved_words_model.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State {
  TextEditingController _controller;
  FocusNode _focusNode;
  String _input = '';
  Future<WordsList> _wordsList;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    String _oldInput = _input;
    setState(() {
      _input = _controller.text;
      if (_input != _oldInput) _wordsList = fetchWordsList(_input);
    });
  }

  void _changeText(String text) {
    _controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFF),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: SearchBar(
                controller: _controller,
                focusNode: _focusNode,
              ),
            ),
            Expanded(
              child: _input == ''
                  ? HistorySearch(onKeywordTap: _changeText)
                  : FutureBuilder<WordsList>(
                      future: _wordsList,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            break;
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return CupertinoActivityIndicator();
                          case ConnectionState.done:
                            if (snapshot.hasData) {
                              List<Word> list = snapshot.data.data;
                              // FutureBuilder in FutureBuilder?
                              return FutureBuilder(
                                  future: Provider.of<SavedWordsModel>(context)
                                      .items,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        itemBuilder: (context, index) =>
                                            WordItem(
                                                index: index,
                                                word: list[index],
                                                showButton: true,
                                                saved: snapshot.data.indexWhere(
                                                        (item) =>
                                                            item.slug ==
                                                            list[index].slug) > -1
                                            ),
                                        itemCount: list.length,
                                      );
                                    }
                                    return Text('loading shared preferences');
                                  }
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            break;
                        }
                        return Container(); // no need width 0?
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
