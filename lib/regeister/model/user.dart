import 'dart:convert';

class User {

  static final User _singletonUser = User._internal();

  User._internal();




  int _userID = 0;
  String _name = "";
  String _phoneNumber = "";
  String _varificationCode = "";
  String Password = "";


  set userID(int value) {
    _userID = value;
  }

  int _gender = 0;
  String _birthday = "";
  String _lat = "";
  String _lng = "";
  String _token = "";
  bool _allowNotification = false;
  String _email = "";
  String _socialToken = "";
  int _status = 1;


  int get userID => _userID;

  String get name => _name;

  String get phoneNumber => _phoneNumber;

  String get varificationCode => _varificationCode;

  int get gender => _gender;

  String get birthday => _birthday;

  String get lat => _lat;

  String get lng => _lng;

  String get token => _token;

  bool get allowNotification => _allowNotification;

  String get email => _email;

  String get socialToken => _socialToken;

  int get status => _status;


  User({
    int userID = 0,
    String name = "",
    String phoneNumber = "",
    String varificationCode = "",
    String userName = "",
    int gender = 0,
    String birthday = "",
    String lat = "",
    String lng = "",
    String token = "",
    bool allowNotification = false,
    String email = "",
    String socialToke = "",
    String pass = "",
    int status = 1,
  }) {
    _userID = userID;
    _name = name;
    _phoneNumber = phoneNumber;
    _varificationCode = varificationCode;

    _gender = gender;
    _birthday = birthday;
    _lat = lat;
    _lng = lng;
    _token = token;
    _allowNotification = allowNotification;
    _email = email;
    _socialToken = socialToken;
    Password = pass;
    _status = status;
  }

  User.fromJson(dynamic json) {
   _userID = json["UserID"];
    _name = json["Name"];
    _phoneNumber = json["PhoneNumber"];
    _varificationCode = json["VarificationCode"];


    _gender = json["Gender"];
    _birthday = json["Birthday"];
    _lat = json["Lat"];
    _lng = json["Lng"];
    _token = json["Token"];
    _allowNotification = json["AllowNotification"];
    _email = json["Email"];
    _socialToken = json["SocialToken"];
    _status = json["Status"];
    Password=json["Password"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["UserID"] = _userID;
    map["Name"] = _name;
    map["PhoneNumber"] = _phoneNumber;
    map["VarificationCode"] = _varificationCode;
    map["Gender"] = _gender;
    map["Birthday"] = _birthday;
    map["Lat"] = _lat;
    map["Lng"] = _lng;
    map["Token"] = _token;
    map["AllowNotification"] = _allowNotification;
    map["Email"] = _email;
    map["SocialToken"] = _socialToken;
    map["Status"] = _status;
    map["Password"]=Password;

    return map;
  }

  set name(String value) {
    _name = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  set varificationCode(String value) {
    _varificationCode = value;
  }


  set gender(int value) {
    _gender = value;
  }

  set birthday(String value) {
    _birthday = value;
  }

  set lat(String value) {
    _lat = value;
  }

  set lng(String value) {
    _lng = value;
  }

  set token(String value) {
    _token = value;
  }

  set allowNotification(bool value) {
    _allowNotification = value;
  }

  set email(String value) {
    _email = value;
  }

  set socialToken(String value) {
    _socialToken = value;
  }

  set status(int value) {
    _status = value;
  }

}