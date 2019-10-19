import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'screens/search_tab.dart';
import 'screens/saved_tab.dart';
import 'model/saved_words_model.dart';
import 'model/searched_keywords_model.dart';

class SearchJishoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => SavedWordsModel(),
        ),
        ChangeNotifierProvider(
          builder: (context) => SearchedKeywordsModel(),
        ),
      ],
      child: CupertinoAppRoot(),
    );
  }
}

class CupertinoAppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bookmark),
            title: Text('Saved'),
          )
        ]
      ),
      tabBuilder: (context, index) {
        CupertinoTabView tabView;
        switch (index) {
          case 0:
            tabView = CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: SearchTab(),
                );
              },
            );
            break;
          case 1:
            tabView = CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: SavedTab(),
                );
              },
            );
            break;
        }
        return tabView;
      },
    );
  }
}