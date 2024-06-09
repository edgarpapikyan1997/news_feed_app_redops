// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      image: json['image'] as String?,
      dep: json['department'] as String,
      postDate: json['post_date'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'image': instance.image,
      'department': instance.dep,
      'post_date': instance.postDate,
      'tags': instance.tags,
      'description': instance.description,
    };
