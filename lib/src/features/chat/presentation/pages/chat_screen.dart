import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../core/constants/images/images.dart';
import '../../data/repo/chat_repo.dart';
import '../../domain/chat_message_model.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController chatController = TextEditingController();
  bool isGenerating = false;

  List<ChatMessageModel> messages = [];
  Future<void> sendMessage() async {

    isGenerating = true;
    // ADD USER INPUT WITH 'USER' ROLE IN THE LIST CHAT MESSAGE MODEL & PASS IT TO API CALL
    messages.add(ChatMessageModel(
      role: 'user',
      parts: [ChatPartModel(text: chatController.text)],
    ));

    // Call the ChatResponseRepo method and handle the response
    String response = await ChatRepo.ChatResponseRepo(messages);

    // Print the response (for debugging purposes)
    print('Response from API: $response');

    // ADD GEMINI MODEL RESPONSE WITH 'MODEL' ROLE IN THE LIST CHAT MESSAGE MODEL
    messages.add(ChatMessageModel(
        role: 'model',
        parts: [ChatPartModel(text: response)]
    ));
    isGenerating = false;
    setState(() {
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // color: HexColor('#d0d1db'),
          color: HexColor('#fdefd4'),
          child: Column(
            children: [
              Expanded(child: ListView.builder(
                itemCount: messages.length,
                  itemBuilder: (context, index){
                  return (messages[index].role== 'user') ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 18,horizontal: 18),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                        color: HexColor('#ffffff'),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "USER",
                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 5),
                          Text(
                            messages[index].parts.first.text,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ): Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 18,horizontal: 18),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(16.r),
                        topLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r)),
                        // color: HexColor('#1565c0'),
                        color: HexColor('#8a6dd9') ,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GEMINI",
                            style: TextStyle(fontSize: 18.sp,color: Colors.white,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 5.h,),
                          Text(messages[index].parts.first.text,
                            style: TextStyle(fontSize: 16.sp,color: Colors.white),)
                        ],
                      ),
                    ),
                  );
                  })),
              if(isGenerating == true) Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: CircularProgressIndicator(color: Colors.black),
              ),
              Container(
                  height: 80.h,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                          child: TextField(
                            controller: chatController,
                            style:TextStyle(fontSize:18.sp),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: HexColor('#f0f0f3'),
                              hintText: 'Ask me anything...',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.r)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: HexColor('#d0d1db'),
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            cursorColor: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 7.0.w,top: 4.h),
                          child: InkWell(
                              onTap: (){
                                print('Send Button Clicked');
                                print('MESSAGE IS: ${chatController.text}');
                                sendMessage();
                                chatController.clear();
                              },
                              child: Container(
                                width: 40.h,
                                height: 40.h,
                                child: Center(
                                  child: SvgPicture.asset(Images.send_icon),
                                ),
                                decoration: BoxDecoration(
                                  color: HexColor('#8a6dd9'),
                                  borderRadius: BorderRadius.circular(50)
                                ),
                              )
                          )
                      )
                    ],
                  )

              )
            ],
          ),
        ),
      ),
    );
  }
}

