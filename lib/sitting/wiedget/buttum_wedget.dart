

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WedgetButtom extends StatelessWidget{
  VoidCallback? method;
  String? text;
  IconData? iconData;
  bool? isLine;
  String? Textalarm;

  WedgetButtom({this.text,this.iconData,this.isLine,this.Textalarm,this.method});
  double width=0,high=0;

  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    high=MediaQuery.of(context).size.height;

    return FlatButton(
            onPressed:  method,
            textColor: Colors.black,
            color: Colors.transparent,
            // padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.t,
                    children: <Widget>[
                      Expanded(child:Container(
                        // padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                        padding: EdgeInsets.symmetric(horizontal: width/33),
                        child: Text(

                          text!,
                          style: TextStyle(color: Color(0xff3c4051),fontSize: 12),
                        ),
                      ),),
                    !Textalarm!.isEmpty?
                    Text(
                     Textalarm!,
                        style: TextStyle(
                          color:  Color(0xff7f92a7),
                          fontSize: 12,
                        ),
                      ):Container(),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Icon(
                            iconData,
                            color: Color(0xff3c4051),
                            size: 12,
                          ),
                        ),

// alignment: Alignment.topRight,
                      ) ,


                    ],
                  ),

                  isLine==true?
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width:width/1.1,
                    child: new Divider(color: Colors.grey,
                      thickness: 1,
                    ) ,):Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                  ),

                ],),

           ));

  }
}
