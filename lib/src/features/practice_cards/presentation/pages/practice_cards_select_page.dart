import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../core/constants/images/images.dart';
import '../../../chat/data/repo/chat_repo.dart';
import '../../../chat/domain/chat_message_model.dart';



class PracticeCardsSelect extends StatefulWidget {
  final List<String> questions;
  final String topic;
  PracticeCardsSelect({required this.questions,required this.topic});

  @override
  State<PracticeCardsSelect> createState() => _PracticeCardsSelectState();
}

class _PracticeCardsSelectState extends State<PracticeCardsSelect> with TickerProviderStateMixin {


  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;
  int _currentIndex = 0;
  String _solution = '';
  bool _isFetchingSolution = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(end: 1.0,begin: 0.0).animate(_controller)
    ..addListener(() {
      setState(() {

      });
    })
    ..addStatusListener((status) {
      _status = status;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    if(_currentIndex==19){
      print('CURRENT INDEX: ${_currentIndex}');
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        title: 'Completed',
        btnOkOnPress: (){
          Navigator.of(context).pop();
        }
      ).show();
    }
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _controller.reset();
        _solution = '';
      });
    }
  }

  Future<void> _fetchSolution(String question)async{
    setState(() {
      _isFetchingSolution = true;
    });

    List<ChatMessageModel> answer = [];
    answer.add(ChatMessageModel(
      role: 'user',
      parts: [ChatPartModel(text: question)],
    ));
    String response = await ChatRepo.ChatResponseRepo(answer);
    print('ANSWER: ${response}');
    setState(() {
      _isFetchingSolution = false;
    });
    setState(() {
      _solution = response;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#e3dcfe'),
        elevation: 0,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( '${_currentIndex + 1}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 30.sp),),
            Text('/${widget.questions.length}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16.sp),),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.0.r),
            child: CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.black,
              child: Center(

                child: SvgPicture.asset('assets/icons/${widget.topic}.svg')
              ),
            )
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: HexColor('#e3dcfe'),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  child: CircleAvatar(
                    radius: 35.r,
                    backgroundColor: HexColor('#5cb65f'),
                    child: Icon(Icons.done,color: Colors.white),
                  )
                ),
                SizedBox(width: 10.w,),
                Text('${_currentIndex} Done',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 18.sp),),
              ],
            ),
            SizedBox(height: 30.h,),
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3,2, 0.0015)
                ..rotateY(pi * _animation.value),
              child: Card(
                elevation: 0,
                color:  HexColor('#e3dcfe'),
                child: _animation.value <= 0.5 ?
                    Container(
                      width: 310.w,
                      height: 350.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0.r),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 73.w,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: HexColor('#5cb65f'),
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(18.r),
                                  ),
                                  child: Center(child: Text('Practice',style: TextStyle(color: Colors.green,fontSize: 15.sp),)),
                                )
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('QUESTION',style: TextStyle(fontSize: 16.sp,color: Colors.white,fontWeight: FontWeight.w400),)
                              ],
                            ),
                            SizedBox(height: 10.h,),
                            Container(
                              height: 180.h,
                              child: Text(widget.questions[_currentIndex],style: TextStyle(fontSize: 19.sp,fontWeight: FontWeight.w600,color: Colors.white),)
                            ),
                            InkWell(
                              onTap: (){
                                _nextQuestion();
                              },
                              child: Container(
                                width: 300.w,
                                height: 40.h,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(16.r),
                                 color: HexColor('#5cb65f'),
                               ),
                                child: Center(
                                  child: Text('I know this Concept :)',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,color: Colors.white),),
                                ),
                              ),
                            ),
                            SizedBox(height: 6.h,),
                            InkWell(
                              onTap: (){
                                print('I do not know this question');
                                if(_status == AnimationStatus.dismissed){
                                  _controller.forward();
                                }
                                print('QUESTION IS: ${widget.questions[_currentIndex]}');
                                _fetchSolution("${widget.questions[_currentIndex]} in short summary of 30-50 words exactly");
                              },
                              child: Container(
                                width: 300.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: HexColor('#c44c4d'),
                                ),
                                child: Center(
                                  child: Text("I dont't know this Concept :(",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,color: Colors.white),),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ) :
                    Transform(
                      alignment: FractionalOffset.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: Container(
                        width: 310.w,
                        height: 350.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: _isFetchingSolution ? CircularProgressIndicator(color: Colors.white)
                              : Padding(
                                padding: EdgeInsets.all(16.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SOLUTION',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                _solution,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                              ),
                        ),
                      ),
                    )
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            InkWell(
              onTap: (){
                if(_status == AnimationStatus.dismissed){
                  _controller.forward();
                  _fetchSolution("${widget.questions[_currentIndex]} in short summary of 30-50 words exactly");
                }
                else{
                  _controller.reverse();
                }
              },
              child: CircleAvatar(
                radius: 35.r,
                backgroundColor: Colors.black,
                child: Icon(Icons.flip,color: Colors.white,size: 40,),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text('Flip to see solution',style: TextStyle(fontSize: 16.sp,color: Colors.black),)
          ],
        ),
      ),
    );
  }
}
