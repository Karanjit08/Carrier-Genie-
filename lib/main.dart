import 'package:carrier_mate/src/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(){
  runApp(flutterApp());
}

class flutterApp extends StatelessWidget {
  const flutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360,640),
      builder:(_,child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnBoardingScreen()
      ),
    );
  }
}
