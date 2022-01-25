import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:yamams_market/service/block_sevice.dart';
import 'package:yamams_market/service/model/product.dart';
import 'package:yamams_market/service/model/service.dart';
import 'package:yamams_market/service/screen/add_service.dart';

class ServiceDetiel extends StatefulWidget {
  Product service;
  ServiceBloc serv=new ServiceBloc();
  ServiceDetiel({required this.service});
  @override
  ServiceDetielBody createState() => ServiceDetielBody();
}

class ServiceDetielBody extends State<ServiceDetiel> {
  @override
  initState() {
    super.initState();
    // Namee.text="em";
    // descript.text="em";
    // pric.text="0";
  }
    double wedth=0,hight=0;
  @override
  Widget build(BuildContext context) {
    wedth=MediaQuery.of(context).size.width;
    hight=MediaQuery.of(context).size.height;

    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 15,
            vertical: MediaQuery.of(context).size.width / 55),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  context.locale==Locale('en')? widget.service.nameEn==null?"": widget.service.nameEn:widget.service.nameAr==null?"":widget.service.nameAr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "DIN Next LT W23",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.service.type==null?"clothes":widget.service.type,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "DIN Next LT W23",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),


                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: hight/88,horizontal: wedth/33),
                    child: Text(
                      context.locale==Locale('en')? widget.service.descriptionEn==null?"":widget.service.descriptionEn: widget.service.descriptionAr==null?"":widget.service.descriptionAr,
                      // textAlign: TextAlign.start,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: "DIN Next LT W23",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    widget.service.price==null?"360":widget.service.price.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "DIN Next LT W23",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: wedth/55),
                      child: IconButton(
                        icon: Image.asset("images/edit.png"),
                        onPressed: () {
                          print("ok");
                          //widget.serv.eventController.sink.add(new EdetService(ser: widget.service));
                          print("product id 2222222"+widget.service.prid.toString());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddService(sservic:widget.service ,)));
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: IconButton(
                        icon: Image.asset("images/share.png"),
                        onPressed: () {
                          print("ok");


                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: IconButton(
                        icon: Image.asset("images/delet.png"),
                        onPressed: () {
                          print("ok");
                          widget.serv.eventController.sink.add(new deletService(ser: widget.service));
                        },
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}
