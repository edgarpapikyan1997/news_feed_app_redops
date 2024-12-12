import 'dart:convert';
import 'package:redops_app/models/post_model/post_model.dart';

import '../example_data.dart';

class LocalDataClient {
  Future<List<PostModel>> getAllPosts() async {
    const jsonPosts = jsonStringPosts;
    final List<dynamic> jsonData = jsonDecode(jsonPosts);
    List<PostModel> postData = jsonData.map((data) => PostModel.fromJson(data)).toList();
    await Future.delayed(const Duration(milliseconds: 500));
    return postData;
  }
}
