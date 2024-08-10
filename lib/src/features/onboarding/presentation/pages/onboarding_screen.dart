import 'package:carrier_mate/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/images/images.dart';
import '../../../navigation_bar/navigation_bar_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnboardingBloc onboardingBloc = OnboardingBloc();

  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      bloc: onboardingBloc,
        listenWhen: (previous,current) => current is OnboardingActionState,
        buildWhen: (previous, current) => current is !OnboardingActionState,
        listener: (context,state){
        if(state is OnboardingClickedButtoNavigateActionState){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavigatioBarScreen()));
        }
        },
        builder: (context,state){
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: HexColor('#e3dcfe'),
          ),
          body: Container(
              width: width.w,
              height: height.h,
              color: HexColor('#e3dcfe'),
              child: Column(
                children: [
                  Container(
                    width: width.w,
                    height: 250.h,
                    child: Lottie.asset('assets/loaders/onboarding_loader.json'),
                  ),
                  Expanded(
                      child: Container(
                        width: width.w,
                        height: 130.h,
                        decoration: BoxDecoration(
                            color: HexColor('#fdefd4'),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.r),
                                topRight: Radius.circular(50.r)
                            )
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 50,left: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Welcome To',style: TextStyle(fontSize: 26.sp,color: HexColor('1d1b1f'),fontWeight: FontWeight.w600,fontFamily: 'Work-Sans-Variable'),),
                                  SizedBox(width: 5.w,),
                                  Text('CarrierMate',style: TextStyle(fontSize: 26.sp,color: HexColor('1d1b1f'),fontWeight: FontWeight.w600,fontFamily: 'Work-Sans-Variable'),)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15),
                              child: Text('Experience personalized learning with our AI Flutter Carrier Mate, where you can ask questions, get instant help, and engage in interactive conversations to enhance your knowledge. Complement your learning with our '
                                  'Practice Cards feature, offering a diverse set of flashcards designed to reinforce concepts and boost your memory.'
                                  ' Join us today and transform your learning journey!',style: TextStyle(fontSize: 14.sp,color: HexColor('#807e97'),fontWeight: FontWeight.w500,height: 1.4,wordSpacing: 2,fontFamily: 'Work-Sans-Variable'),),
                            ),
                            SizedBox(height: 8.h,),
                            InkWell(
                              onTap: (){
                                print('Onboarding Get Started Clicked');
                                onboardingBloc.add(OnboardingButtonClickedNavigateEvent());
                              },
                              child: Container(
                                width: 310.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: HexColor('0f172a'),
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Center(child: Text('Get Started',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Work-Sans-Variable'),)),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              )
          ),
        );
        },
    );
  }
}
