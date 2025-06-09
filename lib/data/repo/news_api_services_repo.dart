import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/data/model/news_response_model.dart';

class NewsApiService {
  /// A service class responsible for fetching news articles from a remote API.
  /// It uses an API key and base URL from environment variables, supports topic-based
  /// search with pagination, and parses the JSON response into a NewsResponseModel.

  final String? _baseUrl = dotenv.env['API_URL'];
  final String? _apiKey = dotenv.env['API_KEY'];

  Future<NewsResponseModel> fetchNews({
    /// Fetches news articles from the API based on the given topic and pagination.
    ///
    /// This method sends a GET request to the remote news API using the provided
    /// [topic], [page], and optional [pageSize] (default is 10). It returns a
    /// [NewsResponseModel] containing the parsed news data.
    ///
    /// Parameters:
    /// - [topic] (required): The keyword or topic to search news for.
    /// - [page] (required): The page number for pagination.
    /// - [pageSize]: Number of articles per page (defaults to 10).
    ///
    /// Returns:
    /// - A [Future] that completes with a [NewsResponseModel] containing the API response.
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
        debugPrint("Page: $page | Articles fetched: ${data['articles']?.length}");
        return NewsResponseModel.fromJson(data);
      } else {
        debugPrint("Error ${response.statusCode}: ${response.body}");
        return NewsResponseModel(); // fallback
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return NewsResponseModel(); // fallback
    }
  }
}
