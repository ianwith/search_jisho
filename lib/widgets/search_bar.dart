import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

import '../model/searched_keywords_model.dart';

const TextStyle searchText = TextStyle(
  color: Color.fromRGBO(0, 0, 0, 1),
  fontSize: 14,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

const Color searchIconColor = Color.fromRGBO(128, 128, 128, 1); 

class SearchBar extends StatelessWidget {
  SearchBar({
    @required this.controller,
    @required this.focusNode
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final SearchedKeywordsModel model = Provider.of<SearchedKeywordsModel>(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xffe0e0e0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              CupertinoIcons.search,
              color: searchIconColor,
            ),
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                style: searchText,
                placeholder: 'Search Jisho',
                autofocus: true,
                onEditingComplete: () {
                  focusNode.unfocus();
                  developer.log('onEditingComplete', name: 'onEditingComplete');
                },
                onSubmitted: (input) {
                  developer.log('$input', name: 'onSubmitted');
                  if (input != '') {
                    model.add(input);
                  }
                }
              ),
            ),
            GestureDetector(
              onTap: controller.clear,
              child: const Icon(
                CupertinoIcons.clear_thick_circled,
                color: searchIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
