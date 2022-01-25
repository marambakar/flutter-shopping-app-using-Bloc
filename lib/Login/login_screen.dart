import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamams_market/controller/bottumBar.dart';
import 'package:yamams_market/regeister/screen/reg_screen.dart';


import 'log_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/src/public_ext.dart';

import 'package:flutter/gestures.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
 // static LogBloc bloc =new LogBloc() ;

 static TextEditingController control1 = new TextEditingController();
  static TextEditingController control2 = new TextEditingController();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double widthScreen = 0.0;
  double hightScreen = 0.0;


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    hightScreen = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(

      body: bodyContent(),
    );
  }


  Widget bodyContent() {
    return Container(
      width: widthScreen,
      height: hightScreen,
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
              height: hightScreen / 3,
              child: Align(alignment: Alignment.bottomCenter,
                child: Image.asset("images/Logo.png"),)),

          Container(
              height: hightScreen / 6,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Log in".tr(), style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "DIN Next LT W23",
                    fontWeight: FontWeight.w700,
                  ),))
          ),
          Container(
              height: hightScreen / 26,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "welcome".tr(),
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
              height: hightScreen / 26,
              padding: EdgeInsets.symmetric(horizontal: widthScreen/6),

              child: Text(
                "First Name".tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: "DIN Next LT W23",
                  fontWeight: FontWeight.w500,
                ),
              )

          ),
          _NameInput(),
          Container(
              height: hightScreen / 26,
              padding: EdgeInsets.symmetric(horizontal: widthScreen/6),
               margin: EdgeInsets.only(top: widthScreen/22),
              child: Text(
                "Password".tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: "DIN Next LT W23",
                  fontWeight: FontWeight.w500,
                ),
              )

          ),
          BlocBuilder<LogBloc, LogState>(
            buildWhen: (previous, current) {
              return previous.password != current.password;
            },
            builder: (context, state) {
              return Container(
                  width: MediaQuery.of(context).size.width/1.5,
                  height:MediaQuery.of(context).size.height/16 ,
                  margin: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width/6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xfffefefe),
                  ),
                  padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width/22),
                  child: TextFormField(


                      controller: LoginScreen.control2,
                    obscureText:  state.isshow,
                    onChanged: (value) =>
                        BlocProvider.of<LogBloc>(context).add(PasswordChanged(password: value)),
                    keyboardType: TextInputType.name,

                    decoration: InputDecoration(
                        suffixIcon:

                        IconButton(
                          icon: Icon(state.isshow?Icons.visibility_off : Icons.visibility), onPressed: () {
                          print("isshow"+state.isshow.toString());
                          state.isshow=!state.isshow;
                                     setState(() {

                                        BlocProvider.of<LogBloc>(context).add(showpassword(show:state.isshow));

                                    });




                        },),
                        errorText: state.isPasswordInvalid != null && state.isPasswordInvalid||state.password=="error"
                            ? 'invalid password'
                            : null),

                  ));

            },
          ),
          Container(
              height: hightScreen /30,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Didnt you acount?".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontFamily: "DIN Next LT W23",
                      fontWeight: FontWeight.w500,
                    ),
                  ))),
          Container(
            height: hightScreen / 45,
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.center,
              child:   FlatButton(
                disabledColor: Colors.transparent,
                onPressed:(){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => reg_screen(),));},
                child: Text(
                  "New Account".tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    decoration: TextDecoration.underline,
                    fontFamily: "DIN Next LT W23",
                    fontWeight: FontWeight.w500,
                  ),
                ),),),),
          _SubmitLogin(),






        ],
      ),),


    );
  }
}

  class _NameInput extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  return BlocBuilder<LogBloc, LogState>(
  buildWhen: (previous, current) {
  return previous.Name != current.Name;
  },
  builder: (context, state) {
  return Container(
    width: MediaQuery.of(context).size.width/1.5,
      height:MediaQuery.of(context).size.height/16 ,
      margin: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width/6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xfffefefe),
      ),
      padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width/22),
      child: TextFormField(


    controller: LoginScreen.control1,
    onChanged: (value) =>
    BlocProvider.of<LogBloc>(context).add(NameChanged(Name: value)),
    keyboardType: TextInputType.name,
    decoration: InputDecoration(

        errorText: state.isNameInvalid != null && state.isNameInvalid||state.Name=="error"
            ? "invalid Name".tr()
            : null),
  ));

  },
  );
  }
  }






  class _SubmitLogin extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return BlocListener(
          bloc: BlocProvider.of<LogBloc>(context),
          listener: (context, state) {
            if (state is LoginFinishedState) {
              print("statet" + state.Name + state.toString());
              if (LoginScreen.control1.text == "") {
                print("lol");

                BlocProvider.of<LogBloc>(context).add(
                    NameChanged(Name: "error"));


              }
              else if (LoginScreen.control2.text == "") {
                print("lol2");

                BlocProvider.of<LogBloc>(context).add(
                    PasswordChanged(password: "error"));

              }
              if (state.isSuccess) {
                print("okkkkk");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BottomBar(index:1)));
              }
              else {
                print("Noooooooo");
              }
            }
            else {
              print("error");
            }
          },

        child: Align(
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
                onPressed: () {
                  BlocProvider.of<LogBloc>(context).add(Submitted());
                },

                child: Text(
                  "Log in".tr(),
                  style: TextStyle(
                    color: Color(0xff3c4051),
                    fontSize: 12,
                    fontFamily: "DIN Next LT W23",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

          ));
    }
  }
