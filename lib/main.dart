import 'package:carrier_mate/src/features/home/presentation/pages/home_screen.dart';
import 'package:carrier_mate/src/features/login/presentation/pages/authentication_form.dart';
import 'package:carrier_mate/src/features/navigation_bar/navigation_bar_screen.dart';
import 'package:carrier_mate/src/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        // home: OnBoardingScreen()
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context,snapshot){
            if(snapshot.hasData){
              return NavigatioBarScreen();
            }
            else{
              return LoginForm();
            }
          }),
        )
      ),
    );
  }
}
