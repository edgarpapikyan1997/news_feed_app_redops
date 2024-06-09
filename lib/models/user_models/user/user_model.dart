import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../data/user_data_model.dart';
import '../support/support_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
 const UserModel({
    required this.userDataModel,
    required this.supportModel,
  });

  final UserDataModel userDataModel;
  final SupportModel supportModel;

  @override
  List<Object> get props => [userDataModel, supportModel];

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJsom() => _$UserModelToJson(this);
}
