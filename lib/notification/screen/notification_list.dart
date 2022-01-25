import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamams_market/controller/bottumBar.dart';
import 'package:yamams_market/notification/data/data_noti.dart';
import 'package:yamams_market/notification/notification_block.dart';
import 'package:yamams_market/notification/screen/notification_detiel.dart';


class NotificationList extends StatefulWidget {

  @override
  NotificationPageBody createState() => NotificationPageBody();
 NotificationBlock noti=new NotificationBlock();
}
class NotificationPageBody extends State<NotificationList> {

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    widget.noti.eventController.sink.add(fetchNotification());
  }


  double widthscreen=0, heightscreen=0;
 bool findText=false;
bool fintselect=false;





  @override
  Widget build(BuildContext context) {
    widthscreen=MediaQuery.of(context).size.width;
    heightscreen=MediaQuery.of(context).size.height;

      return  Scaffold(

        body:   StreamBuilder(
        stream: widget.noti.StateController.stream,
        //output stream (Counetr)
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData&&snapshot.data.allnoti!=null)
            {
              return


                Container(
                  decoration: BoxDecoration(
                  //  color: nextCo

                  image: DecorationImage(

                  image:AssetImage("images/notiBack.png"),
          fit: BoxFit.fill,

          ),),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,

                  children: [
                  Container(
                    margin: EdgeInsets.only(top: heightscreen/18),
                      child:    Center(
                    child: Text("Notification",style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),),
                  ), ),


                    Container(
                      height: heightscreen / 30,
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      margin: EdgeInsets.only(top: heightscreen/33,bottom: 0),
                      child:   FlatButton(
                        disabledColor: Colors.transparent,
                        onPressed:(){
                          widget.noti.eventController.sink.add(eventallRead());
                        },
                        child: Text(
                          "Select all as reading",
                          style: TextStyle(
                            color: Color(0xff3c4051),
                            fontSize: 13,
                            decoration: TextDecoration.underline,
                            fontFamily: "DIN Next LT W23",
                            fontWeight: FontWeight.w500,
                          ),
                        ),),),



       Expanded(
            child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.allnoti.length,
                  itemBuilder: (BuildContext context, int index) {
                                if(index==snapshot.data.allnoti.length-1)
                                  {
                                    findText=true;
                                  }
                                else
                                  {
                                    findText=false;
                                  }
                                if(index==0)
                                  {
                                    fintselect=true;
                                  }
                                else
                                  {
                                    fintselect=false;
                                  }
                    return  Column(
                      children: [

                        Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(bottom: heightscreen/50,left: heightscreen/105,right: heightscreen/105),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(7, 8),
                            ),
                          ],
                          color: snapshot.data.allnoti[index].readed==0? Color(0xff7f92a7): Color(0xffebebeb),
                        ),


                        child:NotificaionDeitel(notificationn: snapshot.data.allnoti[index] ,)
                    ),
                        findText==true?
                            Column(children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Finish Notification",
                                    style: TextStyle(
                                      color: Color(0xff7f92a7),
                                      fontSize: 15,
                                      fontFamily: "DIN Next LT W23",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ) ,
                              ),
                              Container(
                              width: 10.21,
                              height: 11.18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff7f92a7),
                              ),
                            ),
                            Container(
                              height: heightscreen/20,
                            )

                            ],)

                       :Container()
                      ],
                    );



                  }


            ),
          ),


                  ],
              ),
                );




            }
          else{
            print("no notification");
            return Container(
              height: heightscreen,
              width: widthscreen,
              decoration: BoxDecoration(
                //  color: nextCo

                image: DecorationImage(

                  image:AssetImage("images/notiBack.png"),
                  fit: BoxFit.fill,

                ),),
              child: Container(
                height: heightscreen/10,
                width: widthscreen/10,
                decoration: BoxDecoration(
                  //  color: nextCo

                  image: DecorationImage(

                    image:AssetImage("images/notiEmpty.png",),


                  ),),
              )

            );
          }

         }));

  }
}