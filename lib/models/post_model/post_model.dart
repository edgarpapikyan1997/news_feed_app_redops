import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel  extends Equatable{
  const PostModel({
    required this.name,
    required this.avatar,
    required this.image,
    required this.dep,
    required this.postDate,
    required this.tags,
    required this.description,
  });

  final String name;
  final String? avatar;
  final String? image;
  @JsonKey(name: "department")
  final String dep;
  @JsonKey(name: "post_date")
  final String postDate;
  final List<String> tags;
  final String description;


  @override
  List<Object> get props =>
      [name, dep, postDate, tags, description];


  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() =>  _$PostModelToJson(this);
}