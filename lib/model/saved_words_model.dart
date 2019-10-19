import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import 'word.dart';

class SavedWordsModel extends ChangeNotifier {
  static const _prefsKey = 'saved_words';

  // try data persistence for saved words
  String _prefsSavedString;

  final List<Word> _words = [];

  Future<List<Word>> get items async {
    // need async read every time?
    await _loadFromSharedPrefs();
    return _words.reversed.toList();
  }

  Future<void> add(Word word) async {
    _words.add(word);
    await _saveToSharedPrefs();
    notifyListeners();
  }

  Future<void> remove(Word word) async {
    _words.removeWhere((item) => item.slug == word.slug);
    await _saveToSharedPrefs();
    notifyListeners();
  }

  List<Word> fromJSON(Map<String, dynamic> json) =>
      (json['items'] as List).map((d) => Word.fromJSON(d)).toList();

  Map<String, dynamic> toJSON() => {
    'items': _words.map((item) => item.toJSON()).toList()
  };

  Future<void> _saveToSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_prefsKey);
    // just do jsonEncode once, do not encode in every nested level
    await prefs.setString(_prefsKey, jsonEncode(toJSON()));
  }

  Future<void> _loadFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _prefsSavedString = prefs.getString(_prefsKey);
    developer.log('$_prefsSavedString', name: '_prefsSavedString');

    if (_prefsSavedString != null && _prefsSavedString.isNotEmpty) {
      List<Word> _prefsSavedList = fromJSON(jsonDecode(_prefsSavedString));
      _words.clear();
      _prefsSavedList.forEach((f) {
        _words.add(f);
      });
    }
    // add this will cause rebuild repeatedly?
    // notifyListeners();
  }
}
