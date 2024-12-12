import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'support_model.g.dart';

@JsonSerializable()
class SupportModel extends Equatable {
  const SupportModel({
    required this.url,
    required this.text,
  });

  final String url;
  final String text;

  @override
  List<Object> get props => [url, text];

  factory SupportModel.fromJson(Map<String, dynamic> json) =>
      _$SupportModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportModelToJson(this);
}
