import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamams_market/Login/login_screen.dart';
import 'package:yamams_market/regeister/reg_bloc.dart';
import 'package:yamams_market/regeister/screen/reg_screen.dart';
import 'package:yamams_market/regeister/weidget/buttom_wedgiet.dart';
import 'package:yamams_market/regeister/weidget/text_field_weidget.dart';
import 'package:easy_localization/src/public_ext.dart';

class VerificationScreen extends StatefulWidget {


  @override
  verrficaScreenPageState createState() => verrficaScreenPageState();
}
class verrficaScreenPageState extends State<VerificationScreen> {

  double widthScreen = 0,
      highScreen = 0;

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    highScreen = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(

        body: Container(
            width: widthScreen,
            height: highScreen,
            decoration: BoxDecoration(
              //  color: nextCo

              image: DecorationImage(

                image: AssetImage("images/Login.png"),
                fit: BoxFit.fill,

              ),
            ),
            child: SingleChildScrollView(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: highScreen / 3,
                      child: Align(alignment: Alignment.bottomCenter,
                        child: Image.asset("images/Logo.png"),)),
                  Container(
                      height: highScreen / 8,
                      margin: EdgeInsets.only(bottom: highScreen / 48),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("New account".tr(), style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "DIN Next LT W23",
                            fontWeight: FontWeight.w700,
                          ),))
                  ),
                  Container(
                      height: highScreen / 14,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                              "we send the code wait for a minute".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontFamily: "DIN Next LT W23",
                              fontWeight: FontWeight.w500,
                            ),
                          ))
                  ),
                  Container(
                      height: highScreen / 26,
                      padding: EdgeInsets.symmetric(
                          horizontal: widthScreen / 6),

                      child: Text(
                        "Please Enter Your Code:".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      )

                  ),
                  TextFieldWidget(stream: reg_screen.bloc.statevaficationController.stream, event: new addverfi(text: "")),
                  Container(
                      height: highScreen /15,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Did you acount".tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontFamily: "DIN Next LT W23",
                              fontWeight: FontWeight.w500,
                            ),
                          ))),
                  Container(
                    height: highScreen / 15,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child:   FlatButton(
                        disabledColor: Colors.transparent,
                        onPressed:(){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));},
                        child: Text(
                          "Log in".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            decoration: TextDecoration.underline,
                            fontFamily: "DIN Next LT W23",
                            fontWeight: FontWeight.w500,
                          ),
                        ),),),),
                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                    buttumWiedget(method: VerficationPress,text: "continu".tr(),),
                    buttumWiedget(method: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => reg_screen()));
                    },text: "back".tr(),),
                  ],)


                ]))));
  }


  VerficationPress()
  {
  reg_screen.bloc.eventControllerSink.add(continuVerfi(context: context));
}
}




