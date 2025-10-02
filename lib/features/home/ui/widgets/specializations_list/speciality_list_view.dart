import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'speciality_list_view_item.dart';

// import '../../../data/models/specializations_response_model.dart';
// import 'speciality_list_view_item.dart';

class SpecialityListView extends StatefulWidget {
  // final List<SpecializationsData?> specializationDataList;
  // const SpecialityListView({super.key, required this.specializationDataList});
  const SpecialityListView({super.key});

  @override
  State<SpecialityListView> createState() => _SpecialityListViewState();
}

class _SpecialityListViewState extends State<SpecialityListView> {
  var selectedSpecializationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // setState(() {
              //   selectedSpecializationIndex = index;
              // });
              // context.read<HomeCubit>().getDoctorsList(
              //       specializationId: widget.specializationDataList[index]?.id,
              //     );
            },
            child: SpecialityListViewItem(
              // specializationsData: widget.specializationDataList[index],
              itemIndex: index,
              selectedIndex: selectedSpecializationIndex,
            ),
          );
        },
      ),
    );
  }
}
