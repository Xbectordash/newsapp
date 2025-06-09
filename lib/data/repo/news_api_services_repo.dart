import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/data/model/news_response_model.dart';

class NewsApiService {
  final String? _baseUrl = dotenv.env['API_URL'];
  final String? _apiKey = dotenv.env['API_KEY'];

  Future<NewsResponseModel> fetchNews({
    required String topic,
    required int page,
    int pageSize = 10,
  }) async {
    // await Future.delayed(const Duration(seconds: 2));
    final uri = Uri.parse(_baseUrl!).replace(
      queryParameters: {
        'q': topic,
        'from': '2025-06-03',
        'sortBy': 'publishedAt',
        'apiKey': _apiKey!,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      },
    );

    try {
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Page: $page | Articles fetched: ${data['articles']?.length}");
        return NewsResponseModel.fromJson(data);
      } else {
        print("Error ${response.statusCode}: ${response.body}");
        return NewsResponseModel(); // fallback
      }
    } catch (e) {
      print("Exception: $e");
      return NewsResponseModel(); // fallback
    }
  }
}
