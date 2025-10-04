import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/features/home/ui/widgets/home_top_bar.dart';
import 'package:flutter_advance_bloc_course/features/home/ui/widgets/specializations_list/speciality_list_view.dart'
    show SpecialityListView;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/spacing.dart';
import '../logic/home_cubit.dart';
import 'widgets/doctors_blue_container.dart';
import 'widgets/doctors_list/doctors_list_view.dart';
import 'widgets/doctors_list/doctros_bloc_builder.dart';
import 'widgets/doctors_speciality_see_all.dart';
import 'widgets/specializations_list/specializations_bloc_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeTopBar(),
              DoctorsBlueContainer(),
              verticalSpace(24),
              const DoctorsSpecialitySeeAll(),
              verticalSpace(18),
              const SpecializationsBlocBuilder(),
              verticalSpace(8),
              const DoctorsBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
