import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamams_market/regeister/screen/reg_screen.dart';


class buttumWiedget extends StatelessWidget {

 VoidCallback  method;
  String? text;

  buttumWiedget({ required this.method,this.text});
  @override
  Widget build(BuildContext context) {

       return  StreamBuilder(
           stream: reg_screen.bloc.statesurecontinuController.stream,
           //output stream (Counetr)
           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        return Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height / 22),
            height: MediaQuery
                .of(context)
                .size
                .height / 16,
            width: MediaQuery
                .of(context)
                .size
                .width / 3.6,

            child: RaisedButton(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),

              color: Color(0xfffefefe),
              onPressed:
                method,
                // if(snapshot.data!=null) {
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) =>toword));
                // }

                //reg_screen.bloc.eventControllerSink.add(continu()),

              child: Text(
                text!,
                style: TextStyle(
                  color: Color(0xff3c4051),
                  fontSize: 15,
                  fontFamily: "DIN Next LT W23",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

        );});
  }
}