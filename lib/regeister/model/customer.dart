class Customer {
  int _cuid=0;
  String _nameAr="";
  String _nameEn="";
  String _email="";
  String _phoneNumber="";
  double _lat=0;
  double _lang=0;
  int _gender=0;

  set cuid(int value) {
    _cuid = value;
  }

  String _city="";
  int _status=1;
  String _timeStamp="";
  String _dateOfBirth="";
  String _userName="";
  String _password="";
  int _naId=0;
  String _natonAr="";
  String _natonEn="";
  String _faceBookToken="";
  String _InstagramToken="";
  String _desAr="";
  String _desEn="";
  String _Token="";


  String get faceBookToken => _faceBookToken;

  set faceBookToken(String value) {
    _faceBookToken = value;
  }

  int get naId => _naId;

  set naId(int value) {
    _naId = value;
  }

  int get cuid => _cuid;
  int get gender => _gender;
  String get nameAr => _nameAr;
  String get nameEn => _nameEn;
 String get email => _email;
  String get phoneNumber => _phoneNumber;
  double get lat => _lat;
  double get lang => _lang;
  String get city => _city;
  int get status => _status;
  String get timeStamp => _timeStamp;
  String get dateOfBirth => _dateOfBirth;
  String get userName => _userName;
  String get password => _password;


  Customer({
      int cuid=0,
      String nameAr="",
    String nameEn="",
    String email="",
      String phoneNumber="",
      double lat=0,
      double lang=0,
    String city="",
      int status=1,
      String timeStamp="",
      String dateOfBirth="",
    String userName="",
    String password="",
    int gender=0,
    int naid=0,
    String natoAr="",
      String ntonEn="",
    String faceBookTok="",
    String InstagramTok="",
    String desAr="",
    String desEn="",
    String token=""
  }){
    _cuid = cuid;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _email = email;
    _phoneNumber = phoneNumber;
    _lat = lat;
    _lang = lang;
    _city = city;
    _status = status;
    _timeStamp = timeStamp;
    _dateOfBirth = dateOfBirth;
    _userName = userName;
    _password = password;
    _gender=gender;
    _naId=naid;
    _natonAr=natonAr;
    _natonEn=ntonEn;
    _faceBookToken=faceBookTok;
    _InstagramToken=InstagramTok;
    _desAr=desAr;
    _desEn=desEn;
    _Token=token;
}

  Customer.fromJson(dynamic json) {
    _cuid = json["CUID"];
    _nameAr = json["NameAr"];
    _nameEn = json["NameEn"];
    _email = json["Email"];
    _phoneNumber = json["PhoneNumber"];
    _lat = json["Lat"];
    _lang = json["Lang"];
    _city = json["City"];
    _status = json["Status"];
    _timeStamp = json["TimeStamp"];
    _dateOfBirth = json["DateOfBirth"];
    _userName = json["UserName"];
    _password = json["Password"];
   _gender=json["Gender"];
  _naId= json[ "NAID"];
   _natonAr= json["Nationality_Ar"];
   _natonEn=json["Nationality_En"] ;
    _faceBookToken=json["FaceBookToken"];
   _InstagramToken=json ["InstagramToken"];
   _desAr=json["Desc_Ar"];
   _desEn=json["Desc_En"];
   _Token=json["Token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["CUID"] = _cuid;
    map["NameAr"] = _nameAr;
    map["NameEn"] = _nameEn;
    map["Email"] = _email;
    map["PhoneNumber"] = _phoneNumber;
    map["Lat"] = _lat;
    map["Lang"] = _lang;
    map["City"] = _city;
    map["Status"] = _status;
    map["TimeStamp"] = _timeStamp;
    map["DateOfBirth"] = _dateOfBirth;
    map["UserName"] = _userName;
    map["Password"] = _password;
    map["Gender"]=_gender;
    map[ "NAID"]=_naId;
    map["Nationality_Ar"]=_natonAr;
   map["Nationality_En"]=_natonEn ;
    map["FaceBookToken"]=_faceBookToken;
   map ["InstagramToken"]=_InstagramToken;
    map["Desc_Ar"]=_desAr;
    map["Desc_En"]=_desEn;
    map["Token"]=_Token;
    return map;
  }

  set nameAr(String value) {
    _nameAr = value;
  }

  set nameEn(String value) {
    _nameEn = value;
  }

  set email(String value) {
    _email = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  set lat(double value) {
    _lat = value;
  }

  set lang(double value) {
    _lang = value;
  }

  set city(String value) {
    _city = value;
  }

  set status(int value) {
    _status = value;
  }

  set timeStamp(String value) {
    _timeStamp = value;
  }

  String get Token => _Token;

  set Token(String value) {
    _Token = value;
  }

  set dateOfBirth(String value) {
    _dateOfBirth = value;
  }

  set userName(String value) {
    _userName = value;
  }

  set password(String value) {
    _password = value;
  }

  set gender(int value) {
    _gender = value;
  }

  String get natonAr => _natonAr;

  set natonAr(String value) {
    _natonAr = value;
  }

  String get natonEn => _natonEn;

  set natonEn(String value) {
    _natonEn = value;
  }

  String get InstagramToken => _InstagramToken;

  set InstagramToken(String value) {
    _InstagramToken = value;
  }

  String get desEn => _desEn;

  set desEn(String value) {
    _desEn = value;
  }

  String get desAr => _desAr;

  set desAr(String value) {
    _desAr = value;
  }
}