import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamams_market/Login/log_bloc.dart';
import 'package:yamams_market/Login/login_screen.dart';
import 'package:yamams_market/regeister/reg_bloc.dart';
import 'package:yamams_market/regeister/screen/reg_screen.dart';
import 'package:yamams_market/regeister/weidget/buttom_wedgiet.dart';
import 'package:yamams_market/regeister/weidget/text_field_weidget.dart';
import 'package:easy_localization/src/public_ext.dart';


class passwordScreen extends StatefulWidget {


  @override
  PasswordPageState createState() =>PasswordPageState();
}
class PasswordPageState extends State<passwordScreen> {

  double widthScreen = 0,
      highScreen = 0;

  @override
  void dispose() {

  }

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
                      margin: EdgeInsets.only(bottom: highScreen/48),
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
                      height: highScreen / 20,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "For your security enter a password ".tr(),
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
                        "Create Password:".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      )

                  ),
                  TextFieldWidget(stream: reg_screen.bloc.statePasswordController.stream, event: new addPassword(text: "")),
                  Container(
                      height: highScreen / 26,
                      padding: EdgeInsets.symmetric(
                          horizontal: widthScreen / 6),
                      margin: EdgeInsets.only(top: widthScreen / 22),
                      child: Text(
                        "Confirm Password:".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      )

                  ),
                  TextFieldWidget(stream: reg_screen.bloc.statesurePassController.stream, event: new addconfirmPass(text: "")),
                  Container(
                      height: highScreen /30,
                      child: Align(
                          alignment: Alignment.center,
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
                    height: highScreen / 45,
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.center,
                      child:   FlatButton(
                        disabledColor: Colors.transparent,
                        onPressed:(){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  BlocProvider(
                              create: (BuildContext context)=> LogBloc(),
                              child: LoginScreen(),
                            ),));},
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

                  buttumWiedget(method: FinishMethod,text: "finish".tr(),),



                ]))));



  }


  FinishMethod()
  {
    reg_screen.bloc.eventControllerSink.add(passSend(context: context));
  }
}