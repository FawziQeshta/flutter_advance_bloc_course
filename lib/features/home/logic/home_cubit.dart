import 'package:bloc/bloc.dart';
import 'package:flutter_advance_bloc_course/core/helpers/extensions.dart';
import 'package:flutter_advance_bloc_course/core/networking/api_error_model.dart';
import 'package:flutter_advance_bloc_course/core/networking/api_result.dart';
import 'package:flutter_advance_bloc_course/features/home/data/models/specializations_response_model.dart';
import 'package:flutter_advance_bloc_course/features/home/data/repos/home_repo.dart';
import 'package:flutter_advance_bloc_course/features/home/logic/home_state.dart';

import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/helpers/shared_pref_keys.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(HomeState.initial());

  List<SpecializationsData?>? specializationsList = [];

  void getSpecializations() async {
    emit(HomeState.specializationsLoading());
    await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);

    final response = await _homeRepo.getAllSpecializations();

    response.when(
      success: (specializationsResponseModel) {
        emit(HomeState.specializationsSuccess(specializationsResponseModel));
        specializationsList =
            specializationsResponseModel.specializationDataList ?? [];

        getDoctorsList(specializationId: specializationsList?.first?.id);
      },
      failure: (error) {
        emit(HomeState.specializationsError(error));
      },
    );
  }

  void getDoctorsList({int? specializationId}) async {
    List<Doctors?> doctorsList = getDoctorsListBySpecializationId(
      specializationId,
    );

    if (!doctorsList.isNullOrEmpty()) {
      emit(HomeState.doctorsSuccess(doctorsList));
    } else {
      emit(
        HomeState.doctorsError(
          ApiErrorModel(code: 400, message: 'No doctors found'),
        ),
      );
    }
  }

  /// returns the list of doctors based on the specialization id
  getDoctorsListBySpecializationId(specializationId) {
    return specializationsList
        ?.firstWhere((specialization) => specialization?.id == specializationId)
        ?.doctorsList;
  }
}
