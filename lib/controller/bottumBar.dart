

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamams_market/app_locale.dart';
import 'package:yamams_market/homePage/home_bloc.dart';
import 'package:yamams_market/homePage/home_screen.dart';
import 'package:yamams_market/notification/screen/notification_list.dart';
import 'package:yamams_market/sitting/sitting_screen.dart';

class BottomBar extends StatefulWidget {
 // static home_bloc home_blocc = new home_bloc() ;
  int index;
  BottomBar({required this.index});
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

// index given for tabs
 int? currentIndex=0;
  setBottomBarIndex(index){
    setState(() {
      currentIndex = index;
    });
  }

  // Number of tabs
  final tabs = [
    Center(child: NotificationList()),
    Center(child:HomePage()),
    Center(child:SittingScreen()),


  ];
  double width=0,high=0;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    high=MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      body:tabs[currentIndex!],
      bottomNavigationBar:  BottomAppBar(
        color: Colors.transparent,
        elevation: 0,

        //shape: CircularNotchedRectangle(),
        child:AppLocale().locale == Locale('ar')?

    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

    // Icon button 1

        Container(
          width: width/3.2,
          height:high/9.3,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
             topLeft: Radius.circular(40.0),


            ),
            color: Color(0xff3c4051),
          ),
          child:  IconButton(
            icon: Icon(Icons.notifications_none,
              color: Colors.white,size: 30,
            ),
            onPressed: (){
              setBottomBarIndex(0);
            },
            //  splashColor: Colors.white,

          ),
        ),


            Container(
            width: width/5,
            height:width/5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color: Color(0x3f000000),
                  blurRadius: 4,
                  offset: Offset(0, 0),
                ),
              ],
              color: Color(0xffebebeb),

            ),
            child:  IconButton(
                icon: Image.asset("images/barLogo.png",fit: BoxFit.cover),
                onPressed: (){
                  setBottomBarIndex(1);
                },
                //  splashColor: Colors.white,

              ),

          ),


    // Icon button 2
        Container(
          width: width/3.2,
          height:high/9.3,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(40.0),
                topRight: Radius.circular(40.0),


              ),
              color: Color(0xff3c4051),
            ),
          child:  IconButton(
          icon: Icon(Icons.settings,
          color: Colors.white,size: 30,
        ),
        onPressed: (){
          setBottomBarIndex(2);
        },
        //  splashColor: Colors.white,

      ),
    ),]
      ): Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // Icon button 1

              Container(
                width: width/3.2,
                height:high/9.3,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),


                  ),
                  color: Color(0xff3c4051),
                ),
                child:  IconButton(
                  icon: Icon(Icons.notifications_none,
                    color: Colors.white,size: 30,
                  ),
                  onPressed: (){
                    setBottomBarIndex(0);
                  },
                  //  splashColor: Colors.white,

                ),
              ),


              Container(
                width: width/5,
                height:width/5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    ),
                  ],
                  color: Color(0xffebebeb),

                ),
                child:  IconButton(
                  icon: Image.asset("images/barLogo.png",fit: BoxFit.cover),
                  onPressed: (){
                    setBottomBarIndex(1);
                  },
                  //  splashColor: Colors.white,

                ),

              ),


              // Icon button 2
              Container(
                width: width/3.2,
                height:high/9.3,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),


                  ),
                  color: Color(0xff3c4051),
                ),
                child:  IconButton(
                  icon: Icon(Icons.settings,
                    color: Colors.white,size: 30,
                  ),
                  onPressed: (){
                    setBottomBarIndex(2);
                  },
                  //  splashColor: Colors.white,

                ),
              ),]
        )
    ));








  }

  @override
  void initState() {
    currentIndex = widget.index;
  }
}