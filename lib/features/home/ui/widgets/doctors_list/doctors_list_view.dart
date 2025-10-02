import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/features/home/ui/widgets/doctors_list/doctors_list_view_item.dart';

class DoctorsListView extends StatelessWidget {
  // final List<Doctors?>? doctorsList;
  // const DoctorsListView({super.key, this.doctorsList});
  const DoctorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          // return DoctorsListViewItem(doctorsModel: doctorsList?[index]);
          return DoctorsListViewItem();
        },
      ),
    );
  }
}
