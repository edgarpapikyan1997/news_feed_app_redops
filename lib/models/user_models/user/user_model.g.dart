// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userDataModel:
          UserDataModel.fromJson(json['userDataModel'] as Map<String, dynamic>),
      supportModel:
          SupportModel.fromJson(json['supportModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userDataModel': instance.userDataModel,
      'supportModel': instance.supportModel,
    };
