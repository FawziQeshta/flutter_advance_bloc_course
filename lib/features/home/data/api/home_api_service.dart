import 'package:dio/dio.dart';
import 'package:flutter_advance_bloc_course/features/home/data/api/home_api_contants.dart';
import 'package:flutter_advance_bloc_course/features/home/data/models/specializations_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/networking/api_constants.dart';
part 'home_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeApiService {
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET(HomeApiContants.specializationEP)
  Future<SpecializationsResponseModel> getAllSpecializations();
}
