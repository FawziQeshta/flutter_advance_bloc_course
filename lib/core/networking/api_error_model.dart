import 'package:flutter_advance_bloc_course/core/helpers/extensions.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? message;
  final int? code;
  @JsonKey(name: 'data')
  final Map<String, dynamic>? errorsData;

  ApiErrorModel({this.message, this.code, this.errorsData});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  /// Return a String containing all the error messages
  String getAllErrorMessages() {
    if (errorsData.isNullOrEmpty()) return message ?? 'Unknown Error occurred';

    final errorMessage = errorsData!.entries
        .map((entry) {
          final value = entry.value;
          return "${value.join(',')}";
        })
        .join("\n");

    return errorMessage;
  }
}

// this line of code is used to generate the *.g.dart file for json serialization
// any update for this file you need to run the command below
// flutter pub run build_runner build --delete-conflicting-outputs
