import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamams_market/notification/model/notificationnn.dart';
import 'package:yamams_market/notification/notification_block.dart';

import 'package:yamams_market/notification/screen/notification_list.dart';


class NotificaionDeitel extends StatefulWidget {

  Notificationnn notificationn;
  NotificationBlock noti=new NotificationBlock();
  NotificaionDeitel({required this.notificationn});


NotificationDetailState createState() => NotificationDetailState();


}

class NotificationDetailState extends State<NotificaionDeitel>
     {

  @override
  void initState() {
    super.initState();
  }


  double width = 0;
  double height = 0;


  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    print("noooooooooot"+widget.notificationn.readed.toString());
    return

       Row(children: [
         Expanded(child:  Column(

           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(

               padding: EdgeInsets.symmetric(vertical: height/88,horizontal: width/22),
               child: Text(
                 widget.notificationn.headerEn.toString(),
                 textAlign: TextAlign.start,
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 19,
                   fontFamily: "DIN Next LT W23",
                   fontWeight: FontWeight.w700,
                 ),
               ),),
             Container(

               padding: EdgeInsets.symmetric(vertical: height/77,horizontal: width/22),
               child:     Text(
                 widget.notificationn.contentEn.toString(),
                 textAlign: TextAlign.start,
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 12,
                   fontFamily: "DIN Next LT W23",
                   fontWeight: FontWeight.w700,
                 ),
               ),),


           ],

         ),),
        widget.notificationn.readed==0?
         Container(
           padding: EdgeInsets.symmetric(horizontal: 5),
             child:   IconButton(

           icon:    ImageIcon(
               AssetImage("images/eye.png"),
    color:Colors.white,
    size: 25,
    ),
               onPressed: () {
                 print("ok");
                 widget.noti.eventController.sink.add(addeyeevent(notificationn:widget.notificationn ));
               },
             ),
         ):Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child:   IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              print("ok");
              widget.noti.eventController.add((deletEvent(notificationn:widget.notificationn)));
            },
          ),
        )

       ],);



  }
}