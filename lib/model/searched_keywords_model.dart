import 'package:flutter/widgets.dart';

class SearchedKeywordsModel extends ChangeNotifier {
  final List<String> _keywords = [];

  List<String> get items => _keywords;

  int get total => _keywords.length;

  void add(String key) {
    if (_keywords.contains(key)) {
      _keywords.remove(key);
    }
    _keywords.add(key);
    notifyListeners();
  }

  void remove(String key) {
    _keywords.remove(key);
    notifyListeners();
  }
}
