import 'package:redops_app/http/mock_api.dart';
import '../../models/post_model/post_model.dart';

class PostRepository {
  final LocalDataClient _httpClient;

  PostRepository({LocalDataClient? httpClient})
      : _httpClient = httpClient ?? LocalDataClient();

  Future<List<PostModel>> getAllPosts({required int count, required int startIndex}) async {
    final allPosts = await _httpClient.getAllPosts();
    return allPosts.skip(startIndex).take(count).toList();
  }
}

