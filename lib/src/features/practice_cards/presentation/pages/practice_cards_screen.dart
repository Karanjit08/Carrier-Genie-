import 'package:carrier_mate/src/features/chat/domain/chat_message_model.dart';
import 'package:carrier_mate/src/features/practice_cards/presentation/pages/practice_cards_select_page.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../core/constants/images/images.dart';
import '../../../chat/data/repo/chat_repo.dart';



class PracticeCardsScreen extends StatefulWidget {
  const PracticeCardsScreen({super.key});

  @override
  State<PracticeCardsScreen> createState() => _PracticeCardsScreenState();
}

class _PracticeCardsScreenState extends State<PracticeCardsScreen> {


    List<ChatMessageModel> prompts = [];
    bool isGenerating = false;
    Future<void> generateQuestions(String text,String topic)async{
      setState(() {
        isGenerating = true;
      });

      // Show the loading alert
      CoolAlert.show(
        context: context,
        type: CoolAlertType.loading,
        text: 'Loading...',
        barrierDismissible: false, // Prevents the alert from being dismissed by tapping outside
      );

      prompts.add(ChatMessageModel(
        role: 'user',
        parts: [ChatPartModel(text: text)],
      ));

      String response = await ChatRepo.ChatResponseRepo(prompts);
      print('GENERATED QUESTIONS: ${response}');
      final questions = response
          .split('\n')
          .where((line) => line.trim().isNotEmpty && line.trim().startsWith(RegExp(r'\d+\.')))
          .map((line) => line.trim())
          .toList();

      // Dismiss the loading alert
      Navigator.of(context).pop();
      setState(() {
        isGenerating = false;
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PracticeCardsSelect(questions:questions,topic: topic,)));

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  HexColor('#fdefd4'),
        elevation: 0,
        foregroundColor: Colors.black,
        // title: Text('Practice Cards Screen',style: TextStyle(color: Colors.black),),
        // automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: HexColor('#fdefd4'),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Practice Cards',style: TextStyle(fontSize: 25.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                  // Icon(Icons.bookmark_border,size: 30.sp)
                ],
              ),
            ),
            SizedBox(height: 15.h,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Computer Science Engineering',style: TextStyle(fontSize: 18.sp,color: Colors.black,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Programming Languages',style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w400),)
                ],
              ),
            ),
            SizedBox(height: 8.h,),
            Padding(
              padding: EdgeInsets.only(left: 16.0.r),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      String topic = 'java';
                      print('Java Selected');
                      generateQuestions('Generate Top 20 Interview Questions for Java',topic);
                      },
                    child: Container(
                      width: 90.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            child: SvgPicture.asset(Images.java),
                          ),
                          SizedBox(width: 3.w,),
                          Text('Java',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: HexColor('#696969')),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      String topic = 'javascript';
                      print('JavaScript Selected');
                      generateQuestions('Generate Top 20 Interview Questions for JavaScript',topic);
                    },
                    child: Container(
                      // OTHER PROGRAMMING LANGUAGES
                      margin: EdgeInsets.only(left: 10.r),
                      width: 120.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 25.w,
                            height: 22.w,
                            child: SvgPicture.asset(Images.javascript),
                          ),
                          SizedBox(width: 5.w,),
                          Text('JavaScript',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: HexColor('#696969')),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      String topic = 'c++';
                      print('C++ Selected');
                      generateQuestions('Generate Top 20 Interview Questions for C++',topic);
                    },
                    child: Container(
                      // OTHER PROGRAMMING LANGUAGES
                      margin: EdgeInsets.only(left: 10.r),
                      width: 80.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 25.w,
                            height: 25.w,
                            child: SvgPicture.asset(Images.cpp),
                          ),
                          SizedBox(width: 5.w,),
                          Text('C++',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: HexColor('#696969')),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8.h,),
            Padding(
              padding: EdgeInsets.only(left: 16.0.r),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      String topic = 'dart';
                      print('Dart Selected');
                      generateQuestions('Generate Top 20 Interview Questions for Dart',topic);
            },
                    child: Container(
                      width: 80.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            child: SvgPicture.asset(Images.dart),
                          ),
                          SizedBox(width: 3.w,),
                          Text('Dart',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: HexColor('#696969')),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      String topic = 'python';
                      print('Python Selected');
                      generateQuestions('Generate Top 20 Interview Questions for Python',topic);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10.r),
                      width: 90.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            child: SvgPicture.asset(Images.python),
                          ),
                          SizedBox(width: 3.w,),
                          Text('Python',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: HexColor('#696969')),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Mobile Development',style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w400),)
                ],
              ),
            ),
            SizedBox(height: 8.h,),
            Padding(
              padding: EdgeInsets.only(left: 16.0.r),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      String topic = 'flutter';
                      print('Flutter Selected');
                      generateQuestions('Generate Top 20 Interview Questions for Flutter',topic);
            },
                    child: Container(
                      width: 90.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            child: SvgPicture.asset(Images.flutter),
                          ),
                          SizedBox(width: 3.w,),
                          Text('Flutter',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: HexColor('#696969')),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      String topic = 'android';
                      print('Android Selected');
                      generateQuestions('Generate Top 20 Interview Questions for Native Android',topic);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10.r),
                      width: 140.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            child: SvgPicture.asset(Images.android),
                          ),
                          SizedBox(width: 3.w,),
                          Text('Android SDK',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: HexColor('#696969')),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Web Development',style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w400),)
                ],
              ),
            ),
            SizedBox(height: 8.h,),
            Padding(
              padding: EdgeInsets.only(left: 16.0.r),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      String topic = 'node_js';
                      print('Node Js Selected');
                      generateQuestions('Generate Top 20 Interview Questions for Node Js',topic);
            },
                    child: Container(
                      width: 100.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            child: SvgPicture.asset(Images.node_js),
                          ),
                          SizedBox(width: 3.w,),
                          Text('Node Js',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: HexColor('#696969')),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      String topic = 'react';
                      print('React Selected');
                      generateQuestions('Generate Top 20 Interview Questions for React',topic);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10.r),
                      width: 90.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            child: SvgPicture.asset(Images.react),
                          ),
                          SizedBox(width: 3.w,),
                          Text('React',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: HexColor('#696969')),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // if (isGenerating)
            //   Center(
            //     child: CircularProgressIndicator(color: Colors.black),
            //   ),

          ],
        ),
      ),
    );
  }
}
