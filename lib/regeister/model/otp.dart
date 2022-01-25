

import 'package:yamams_market/homePage/store_model.dart';
import 'package:yamams_market/regeister/model/customer.dart';


class Otp {
  int _otid=0;
  String _code="";
  String _phoneNumber="";
  int _cuid=0;
  int _status=1;
  String _timeStamp="";
  int _owid=0;
  Customer _customer=new Customer();
  Store_model _store=new Store_model();

  int get otid => _otid;
  String get code => _code;
  String get phoneNumber => _phoneNumber;
  int get cuid => _cuid;
  int get status => _status;
  String get timeStamp => _timeStamp;
  int get owid => _owid;
  Customer get customer => _customer;
  Store_model get store => _store;

  Otp({
      int otid=0,
      String code="",
      String phoneNumber="",
      int cuid=0,
      int status=0,
      String timeStamp="",
      int owid=0,
     required Customer customer,
   required Store_model store}){
    _otid = otid;
    _code = code;
    _phoneNumber = phoneNumber;
    _cuid = cuid;
    _status = status;
    _timeStamp = timeStamp;
    _owid = owid;
    _customer = customer;
   _store = store;
}

  Otp.fromJson(dynamic json) {
    _otid = json["OTID"];
    _code = json["Code"];
    _phoneNumber = json["PhoneNumber"];
    _cuid = json["CUID"];
    _status = json["Status"];
    _timeStamp = json["TimeStamp"];
    _owid = json["OWID"];
    if (json["Customer"] != null) {

     _customer=Customer.fromJson(json["Customer"]);
    }
    if (json["Store"] != null) {

     _store=Store_model.fromJson(json["Store"]);
    }

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["OTID"] = _otid;
    map["Code"] = _code;
    map["PhoneNumber"] = _phoneNumber;
    map["CUID"] = _cuid;
    map["Status"] = _status;
    map["TimeStamp"] = _timeStamp;
    map["OWID"] = _owid;

    if(_customer!=null)
      {
      map["Customer"]= _customer.toJson();
      }
    if(_store!=null)
    {
      map["Store"]= _store.toJson();
    }
    return map;
  }

  set store(Store_model value) {
    _store = value;
  }

  set customer(Customer value) {
    _customer = value;
  }

  set owid(int value) {
    _owid = value;
  }

  set timeStamp(String value) {
    _timeStamp = value;
  }

  set status(int value) {
    _status = value;
  }

  set cuid(int value) {
    _cuid = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  set code(String value) {
    _code = value;
  }

  set otid(int value) {
    _otid = value;
  }
}