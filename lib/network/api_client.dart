import 'package:http/http.dart' as http;
import 'dart:convert';
import '../entity/search_repository.dart';

class APIClient {
  final String baseUrl = 'https://api.github.com';

  Future<SearchRepository> getSearchRepository(String q) async {
    final response = await http.get(Uri.parse('$baseUrl/search/repositories?q=$q'));
    if (response.statusCode == 200) {
      return SearchRepository.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load example data');
    }
  }
}