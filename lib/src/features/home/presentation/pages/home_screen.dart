import 'package:carrier_mate/src/features/chat/presentation/pages/chat_screen.dart';
import 'package:carrier_mate/src/features/practice_cards/presentation/pages/practice_cards_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: HexColor('#135caf'),
        elevation: 0,
        centerTitle: false,
        backgroundColor: HexColor('#fefefe'),
        title: Padding(
          padding: EdgeInsets.only(left: 8.r),
          child: Text('Welcome!! ⚡️',style: TextStyle(color: Colors.black),),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 20.r),
            child: InkWell(
              onTap: ()async{
                await FirebaseAuth.instance.signOut();
              },
                child: Icon(Icons.logout,color: Colors.black,)),
          )
        ],
      ),
      body: Container(
        width: width.w,
        height: height.h,
        color: HexColor('#fefefe'),
        child: Column(
          children: [
            SizedBox(height: 15.h,),
            Container(
              width: 320.w,
              height: 160.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color:  HexColor('#fdefd4'),
              ),
              child: Column(
                children: [
                  SizedBox(height: 8.h,),
                  Container(
                    width: 300.w,
                    height: 50.h,
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/ai.svg'),
                        SizedBox(width: 10.w,),
                        Container(
                          width: 200.w,
                          height: 50.h,
                          // color: Colors.green,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Hi, I'm Karan",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600,color: HexColor('#af8441'),)),
                              Text("your interview coach",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600,color: HexColor('#af8441'),))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    child: Divider(
                      height: 4.h,
                      thickness: 3,
                      color: HexColor('#eebf37'),
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.r),
                    child: Text('Connect with our AI to practice common interview '
                        'questions, receive instant feedback, '
                        'and get tips on improving your responses.',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,height: 1.4,wordSpacing: 2,fontFamily: 'Work-Sans-Variable',color: HexColor('#0f1729')),),
                  )
                ],
              ),
            ),
            SizedBox(height: 15.h,),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              child: Container(
                width: 320.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: HexColor('#f0edfe'),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 265.w,
                      height: 50.h,
                      // color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.only(left: 6.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('AI Chat for Interview Prep',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: HexColor('20005a')),),
                            SizedBox(height: 2.h,),
                            Text('Connect with AI Assistant & Clarify Your Doubts',style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w500,color: HexColor('737c6c')),)

                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w,),
                    Container(
                      width: 45.w,
                      height: 50.h,
                      // color: Colors.black,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: HexColor('#e3dcfe'),
                        child: Center(
                          child: Icon(Icons.arrow_forward,color: HexColor('20005a'),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h,),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PracticeCardsScreen()));

              },
              child: Container(
                width: 320.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: HexColor('#ffe7e7'),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 265.w,
                      height: 50.h,
                      // color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.only(left: 6.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Rapid practice flash card',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: HexColor('ef8687')),),
                            SizedBox(height: 2.h,),
                            Text('Brush through every aspect of any skills',style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w500,color: HexColor('737c6c')),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w,),
                    Container(
                      width: 45.w,
                      height: 50.h,
                      // color: Colors.black,
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: HexColor('#fecdd1'),
                        child: Center(
                          child: Icon(Icons.arrow_forward,color: HexColor('21005d'),),
                        ),
                      ),
                    ),
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
