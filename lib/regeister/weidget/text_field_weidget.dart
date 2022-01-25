import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamams_market/regeister/reg_bloc.dart';
import 'package:yamams_market/regeister/screen/reg_screen.dart';


class TextFieldWidget extends StatelessWidget{

  String val="";
  Stream stream;
  registerEvent event;
  TextFieldWidget({required this.stream,required this.event});
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: stream,
        //output stream (Counetr)
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          return   Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.5,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 16,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery
                  .of(context)
                  .size
                  .width / 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xfffefefe),
              ),
              padding: EdgeInsets.symmetric(horizontal: MediaQuery
                  .of(context)
                  .size
                  .width / 22),
              child: TextFormField(
                initialValue: "",
                onChanged: (value) {
                  event.text=value;
                 reg_screen.bloc.eventControllerSink.add(event);

                  val=value;
                },

                keyboardType: TextInputType.name,
                style: TextStyle(fontSize: MediaQuery.of(context).size.width/33),
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize:MediaQuery.of(context).size.width/44 ),
                  errorText: snapshot.data == null
                      ?   snapshot.error==null? null: snapshot.error.toString()
                      : null,
                ),
              ));});
  }
}