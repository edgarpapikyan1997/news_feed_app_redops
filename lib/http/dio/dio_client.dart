import 'package:dio/dio.dart';
import 'package:redops_app/models/data/user_data_model.dart';

class DioClient {
  // http: //18.217.172.204/api/user/posts
  final String apiBaseUrl = 'http://18.217.172.204/';
  final Dio _dio = Dio(
    BaseOptions(
        receiveTimeout: Duration(
          milliseconds: 5000,
        ),
        connectTimeout: Duration(milliseconds: 5000)),
  );

  Future<UserDataModel> getSingleUser(int id) async {
    final Response response = await _dio.get('${apiBaseUrl}api/users/$id');

    return UserDataModel.fromJson(response.data['data']);
  }

  Future<List<UserDataModel>> getAllUsers({required int page}) async {
    try {
      final Response response = await _dio.get(
          '${apiBaseUrl}api/users?page=$page');
      if (response.statusCode == 200) {
        final List<dynamic> result = response.data['data'];
        print('RESULT IS >>>>');
        print(result);

        List<UserDataModel> data = result.map((e) => UserDataModel.fromJson(e))
            .toList();
        return data;
      } else {
        throw Exception(response.data['data']);
      }
    } on DioException catch (error) {
      throw Exception(error);
    }
  }

  Future<dynamic> getAllPosts() async {
    try {
      final Response response = await _dio.get(
          'http://18.217.172.204/api/user/posts');
      print(response.data);
      return response.data;
    } on
    DioException catch (e) {
      print(e);
    }
  }
}
