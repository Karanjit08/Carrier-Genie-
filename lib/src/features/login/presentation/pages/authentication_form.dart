import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/services/authentication.dart';



class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#fdefd4'),
        centerTitle: true,
        title: isLogin ? Text('Login',style: TextStyle(color: Colors.black),) : Text('Sign Up',style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height,
        color: HexColor('#fdefd4'),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.h,
              child: Lottie.asset('assets/loaders/onboarding_loader.json'),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    if(!isLogin) TextFormField(
                      cursorColor: HexColor('0f172a'),
                      key: ValueKey('first_name'),
                      decoration: InputDecoration(
                          hintText: 'Enter First Name',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                              color: HexColor('0f172a'),
                            ),
                          ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                            color: HexColor('0f172a'),
                            width: 1.0,
                          ),
                        ),
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
                    SizedBox(height: 10.h,),
                    if(!isLogin) TextFormField(
                      cursorColor: HexColor('0f172a'),
                      key: ValueKey('last_name'),
                      decoration: InputDecoration(
                          hintText: 'Enter Last Name',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                              color: HexColor('0f172a'),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                              color: HexColor('0f172a'),
                              width: 1.0,
                            ),
                          )
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
                    SizedBox(height: 10.h,),
                    TextFormField(
                      cursorColor: HexColor('0f172a'),
                      key: ValueKey('email'),
                      decoration: InputDecoration(
                          hintText: 'Enter Email Id',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                              color: HexColor('0f172a'),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                              color: HexColor('0f172a'),
                              width: 1.0,
                            ),
                          )
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
                    SizedBox(height: 10.h,),
                    TextFormField(
                      cursorColor: HexColor('0f172a'),
                      obscureText: true,
                      key: ValueKey('password'),
                      decoration: InputDecoration(
                          hintText: 'Enter Password',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                              color: HexColor('0f172a'),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                              color: HexColor('0f172a'),
                              width: 1.0,
                            ),
                          )
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
                        },style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor('0f172a'),
                        ),
                            child:  isLogin ? Text('Login') : Text('Sign Up'))),
                    SizedBox(height: 10.h,),
                    TextButton(onPressed: (){
                      changeIsLogin();
                    },style: TextButton.styleFrom(foregroundColor: HexColor('#807e97'),),
                        child:isLogin ?Text("Don't have an account? SignUp") : Text('Already have an account? LogIn'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
