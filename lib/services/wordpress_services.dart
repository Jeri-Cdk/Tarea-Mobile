import 'package:dio/dio.dart';
import '../models/post.dart';

class ApiService {
  final String baseUrl;
  final Dio _dio = Dio();

  ApiService(this.baseUrl);

  Future<List<Post>> fetchPosts() async {
    try {
      final response =
          await _dio.get('$baseUrl/wp-json/wp/v2/posts?per_page=3');
      List<dynamic> data = response.data;
      return data.map((post) => Post.fromJson(post)).toList();
    } catch (e) {
      throw Exception('Error al cargar las noticias: $e');
    }
  }

  Future<String> fetchSiteName() async {
    try {
      final response = await _dio.get('$baseUrl/wp-json');
      return response.data['name'] ?? 'WordPress Site';
    } catch (e) {
      throw Exception('Error al cargar el nombre del sitio: $e');
    }
  }
}
