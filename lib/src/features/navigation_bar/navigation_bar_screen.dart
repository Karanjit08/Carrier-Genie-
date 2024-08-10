import 'package:carrier_mate/src/features/chat/presentation/pages/chat_nav_bar.dart';
import 'package:carrier_mate/src/features/home/presentation/pages/home_screen.dart';
import 'package:carrier_mate/src/features/practice_cards/presentation/pages/practice_cards_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';



class NavigatioBarScreen extends StatelessWidget {
  NavigatioBarScreen({super.key});
  final _pageController = PageController();


  @override
  void dispose() {
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomeScreen(),
          ChatNavBar(),
          PracticeCardsScreen()
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        // color: HexColor('#40c4ff'),
        color:  HexColor('#f0f0f3'),
        controller: _pageController,
        flat: true,
        useActiveColorByDefault: false,
        itemColor:  HexColor('#9f9f9f'),
        items: [
          RollingBottomBarItem(Icons.home,
              label: 'Home', activeColor: HexColor('#8a6dd9')),
          RollingBottomBarItem(Icons.chat,
              label: 'Chats', activeColor: HexColor('#8a6dd9')),
          RollingBottomBarItem(Icons.note_alt,
              label: 'Cards', activeColor: HexColor('#8a6dd9')),
        ],
        enableIconRotation: true,
        onTap: (index){
          _pageController.animateToPage(
              index, duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut);
        },
      ),
    );
  }
}
