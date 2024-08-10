import 'package:carrier_mate/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:carrier_mate/src/features/chat/presentation/pages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';


class ChatNavBar extends StatefulWidget {
  const ChatNavBar({super.key});

  @override
  State<ChatNavBar> createState() => _ChatNavBarState();
}

class _ChatNavBarState extends State<ChatNavBar> {
  @override

  final ChatBloc chatBloc = ChatBloc();
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc,ChatState>(
      bloc: chatBloc,
        listenWhen: (previous,current) => current is ChatActionState,
        buildWhen: (current,previous) => current is !ChatActionState,
        listener: (context,state){
        if(state is ChatNavBarButtonClickedActionState){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen()));
        }
        },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor:  HexColor('#fdefd4'),
            title: Text('Chat Screen',style: TextStyle(color: Colors.black),),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: InkWell(
              onTap: (){
                chatBloc.add(ChatNavBarButtonClickedEvent());
              },
              child: Container(
                width: 330.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: HexColor('#8a6dd9')
                ),
                child: Text('Get Started',style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold,color: HexColor('#FFFFFF')),),
              ),
            ),
          ),
        );
      },
    );
  }
}
