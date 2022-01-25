import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamams_market/Login/login_screen.dart';
import 'package:yamams_market/controller/bottumBar.dart';
import 'package:yamams_market/helper/ValidatorsTransformer.dart';
import 'package:yamams_market/homePage/store_model.dart';
import 'package:yamams_market/regeister/model/customer.dart';
import 'package:yamams_market/regeister/model/otp.dart';
import 'package:http/http.dart' as http;

part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  LogBloc() : super(LogState()) ;

  @override
  Stream<LogState> mapEventToState(
      LogEvent event,
      ) async* {
    if (event is NameChanged) {
      yield* _mapNameChangedToState(event.Name);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }   else if (event is showpassword) {
      yield* _mapshowpasswordToState(event.show);
    }
    else if (event is Submitted) {
      yield* _mapSubmittedLoginToState();
    }
  }


  Stream<LogState> _mapNameChangedToState(String Name) async* {
    yield state.copyWith(
        Name: Name, isNameInvalid: !ValidatorsTransformer.isValidName(Name), );
  }

  Stream<LogState> _mapPasswordChangedToState(String password) async* {
    yield state.copyWith(
        password: password,
        isPasswordInvalid: !ValidatorsTransformer.isValidPassword(password));
  }
  Otp otp=new Otp(customer: new Customer(), store: new Store_model());
  Stream<LogState> _mapSubmittedLoginToState() async* {
    print(state.isNameInvalid);
    if (LoginScreen.control1.text!="" && LoginScreen.control2.text!="") {
      try {
           Customer custumer=new Customer(userName: LoginScreen.control1.text,password: LoginScreen.control2.text)  ;
           print("Cusromer"+custumer.userName);

        otp= await createotp("http://yamamstore.fingerprint.ml/api/OTP/LogIn",
          body: json.encode(custumer.toJson()),);
       // print("otp0000000"+otp.phoneNumber.toString());

        if(otp!=null) {
        await  SaveData(otp);
          yield LoginFinishedState(isSuccess: true);

        }
        else
          {
            print("the otp null");

          }


      } on Exception catch (e) {
        print(e);
        yield LoginFinishedState(isSuccess: false);
      }
    } else {
      yield LoginFinishedState(isSuccess: false);
    }
  }

  Stream<LogState> _mapshowpasswordToState(bool isshow) async* {
   // state.isshow=!state.isshow;
   print("state.isshow"+isshow.toString());
    yield state.copyWith(
      isshow:isshow  );
  }


    Future<Otp> createotp(String url, {required String body}) async {
    print("uri******"+Uri.parse(url).toString()+body.toString());
    return http.post(Uri.parse(url), body: body,headers: {
    "Accept": "application/json",
    "content-type": "application/json"}).then((http.Response response) {
    final int statusCode = response.statusCode;
    print("cod"+response.statusCode.toString());

    if (statusCode < 200 || statusCode > 400 || json == null) {
    throw new Exception("Error while fetching data");
    }
    if(statusCode==200) {
    print("body" + response.body);

    }
    if(json.decode(response.body)["data"]==null)
    {
      if ((json.decode(response.body)["ErroCode"] == 2)){
        Fluttertoast.showToast(
            msg: jsonDecode(response.body)["ErrorMessage"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
             return json.decode(response.body)["data"];
    }
    else {
      print("nivo" + Otp
          .fromJson(json.decode(response.body)["data"])
          .phoneNumber
          .toString());
      return Otp.fromJson(json.decode(response.body)["data"]);
    }

    });
    }

  Future<void> SaveData(Otp userr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(userr.toJson());
    print("mmmmmmm"+json.encode(userr.toJson()));
    await prefs.setString('User_data', encodedData);

  }
}
