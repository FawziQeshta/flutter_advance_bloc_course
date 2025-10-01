import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/theming/app_assets.dart';
import 'package:flutter_advance_bloc_course/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DoctorImageAndText extends StatelessWidget {
  const DoctorImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(AppAssets.docdocLogoLowOpacity),
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white.withOpacity(0.0)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.14, 0.4],
            ),
          ),
          child: Image.asset(AppAssets.onboardingDoctor),
        ),
        Positioned(
          child: Text(
            'Best Doctor Appointment App',
            textAlign: TextAlign.center,
            style: TextStyles.font32BlueBold.copyWith(height: 1.4),
          ),
          bottom: 30.h,
          left: 10.h,
          right: 10.h,
        ),
      ],
    );
  }
}
