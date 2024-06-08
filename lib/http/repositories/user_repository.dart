import 'package:flutter/cupertino.dart';
import 'package:redops_app/http/dio/dio_client.dart';
import 'package:redops_app/models/data/user_data_model.dart';

class UserRepository {
  UserRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  Future<UserDataModel?> getSingleUser(int id) async {
    return await _dioClient.getSingleUser(id);
    // return await _dioClient.getUser(id: id);
  }

  Future<List<UserDataModel>> getUsers({required int page}) async {
    return await _dioClient.getAllUsers(page: page);
  }
}
