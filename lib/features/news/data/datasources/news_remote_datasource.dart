import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/news_article_entity.dart';

class NewsRemoteDatasource {
  static const _apiKey = 'f2d2ae236688492f9df99af41206f130';
  static const _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<NewsArticleEntity>> fetchTechNews() async {
    final url =
        Uri.parse('$_baseUrl?category=technology&language=en&apiKey=$_apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'] ?? [];
      return articles.map((json) => NewsArticleEntity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news: \\${response.reasonPhrase}');
    }
  }
}
