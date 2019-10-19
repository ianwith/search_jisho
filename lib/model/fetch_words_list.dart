import 'dart:convert';
import 'package:http/http.dart' as http;

import 'words_list.dart';

Future<WordsList> fetchWordsList(String keyword) async {
  final response =
      await http.get('https://jisho.org/api/v1/search/words?keyword=$keyword');
  if (response.statusCode == 200) {
    return WordsList.fromJSON(jsonDecode(response.body));
  } else {
    throw Exception('Failed to search word $keyword');
  }
}
