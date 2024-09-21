import 'package:carrier_mate/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/images/images.dart';
import '../../../../core/services/authentication.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../login/presentation/pages/authentication_form.dart';
import '../../../navigation_bar/navigation_bar_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnboardingBloc onboardingBloc = OnboardingBloc();

  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  String fName = '';
  String lName = '';
  String email = '';
  String password = '';

  void changeIsLogin(){
    setState(() {
      isLogin = !isLogin;
    });
  }

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
            centerTitle: true,
            title: isLogin ? Text('Login') : Text('Sign Up'),
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
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        children: [
                          if(!isLogin) TextFormField(
                            key: ValueKey('first_name'),
                            decoration: InputDecoration(
                                hintText: 'Enter First Name'
                            ),
                            validator: (val){
                              if(val!.length<2){
                                return 'Please enter a valid First Name';
                              }
                              else{
                                return null;
                              }
                            },
                            onSaved: (val){
                              setState(() {
                                fName = val.toString();
                              });
                            },
                          ),
                          if(!isLogin) TextFormField(
                            key: ValueKey('last_name'),
                            decoration: InputDecoration(
                                hintText: 'Enter Last Name'
                            ),
                            validator: (val){
                              if(val!.length<2){
                                return 'Please enter a valid Last Name';
                              }
                              else{
                                return null;
                              }
                            },
                            onSaved: (val){
                              setState(() {
                                lName = val.toString();
                              });
                            },
                          ),
                          TextFormField(
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                                hintText: 'Enter Email Id'
                            ),
                            validator: (val){
                              if(val!.toString().isEmpty || !val.toString().contains('@')){
                                return 'Please enter a valid Email Id';
                              }
                              else{
                                return null;
                              }
                            },
                            onSaved: (val){
                              setState(() {
                                email = val.toString();
                              });
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            key: ValueKey('password'),
                            decoration: InputDecoration(
                                hintText: 'Enter Password'
                            ),
                            validator: (val){
                              if(val.toString().length<6){
                                return 'Please enter a valid Password';
                              }
                              else{
                                return null;
                              }
                            },
                            onSaved: (val){
                              setState(() {
                                password = val.toString();
                              });
                            },
                          ),
                          SizedBox(height: 20.h,),
                          SizedBox(
                              width: double.maxFinite,
                              height: 50,
                              child: ElevatedButton(onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  _formKey.currentState!.save();
                                  isLogin ?
                                  AuthenticationFunctions.signIn(context, email, password)
                                      :
                                  AuthenticationFunctions.signUp(context, email, password);

                                }
                              }, child:  isLogin ? Text('Login') : Text('Sign Up'))),
                          SizedBox(height: 10.h,),
                          TextButton(onPressed: (){
                            changeIsLogin();
                          }, child:isLogin ?Text("Don't have an account? SignUp") : Text('Already have an account? LogIn'))
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
        );
        },
    );
  }
}
