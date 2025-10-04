import 'package:flutter_advance_bloc_course/core/networking/api_error_handler.dart';
import 'package:flutter_advance_bloc_course/core/networking/api_result.dart';
import 'package:flutter_advance_bloc_course/features/home/data/api/home_api_service.dart';
import 'package:flutter_advance_bloc_course/features/home/data/models/specializations_response_model.dart';

class HomeRepo {
  final HomeApiService _apiService;

  HomeRepo(this._apiService);

  Future<ApiResult<SpecializationsResponseModel>>
  getAllSpecializations() async {
    try {
      final response = await _apiService.getAllSpecializations();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
