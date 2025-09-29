import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String message;
  final int code;

  ApiErrorModel({
    required this.message,
    required this.code,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
}
// this line of code is used to generate the *.g.dart file for json serialization
// any update for this file you need to run the command below
// flutter pub run build_runner build --delete-conflicting-outputs
