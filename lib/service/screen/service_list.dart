import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamams_market/service/block_sevice.dart';
import 'package:yamams_market/service/wedgiet/service_detail.dart';

class ServiceList extends StatefulWidget {
  ServiceBloc serviceBloc=new ServiceBloc();

  @override
  ServicePageBody createState() => ServicePageBody();

}
class ServicePageBody extends State<ServiceList> {

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    widget.serviceBloc.eventController.add(new addAllService());

  }


  double widthscreen=0, heightscreen=0;
  bool findText=false;






  @override
  Widget build(BuildContext context) {
    widthscreen=MediaQuery.of(context).size.width;
    heightscreen=MediaQuery.of(context).size.height;

    return  Scaffold(

        body:   StreamBuilder(
            stream: widget.serviceBloc.stateAllService.stream,
            //output stream (Counetr)
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasData)
              {
                return



                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,

                      children: [
                        Container(
                          margin: EdgeInsets.only(top: heightscreen/18),
                          child:    Center(
                            child: Text(" Service Management".tr(),style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),),
                          ), ),




                        snapshot.data.length!=0?
                       
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                if(index==snapshot.data.length-1)
                                  {
                                    findText=true;
                                  }
                                else{
                                  findText=false;
                                }

                                return  Column(
                                  children: [

                                    Container(

                                        margin: EdgeInsets.only(bottom: heightscreen/50,left: heightscreen/105,right: heightscreen/105),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(28),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x3f000000),
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                          color: Color(0xff7f92a7),
                                        ),


                                        child:ServiceDetiel(service: snapshot.data[index] ,)
                                    ),
                                    findText==true?
                                    Column(children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 5),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Finish Services",
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
                                        width: widthscreen/55,
                                        height: widthscreen/55,
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
                        ):Expanded(child: Center(child: Text("No service"),)),


                      ],

                  );




              }
              else{
                print("no services");
                return Container(
                    height: heightscreen,
                    width: widthscreen,
                    decoration: BoxDecoration(


                    ),


                );
              }

            }));

  }


}