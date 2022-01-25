/// SID : 1041
/// Name_Ar : "سبورات "
/// Name_En : "Store22"
/// Desc_Ar : "متجر لعرض احدث المنتجات "
/// Desc_En : "Shop to display the latest products"
/// Lat : 24.78721064
/// Lng : 46.67168586
/// Photo : "yamamstore.fingerprint.ml\\images\\1006_Store_download (1).jpg"
/// Status : 1
/// Rate : 0
/// Raters : 0
/// City_Ar : "رياض"
/// OpenTime : "9"
/// CloseTime : "10"
/// Tax : 0
/// TaxAmount : 0
/// Timestamp : "2021-10-10T17:12:13.783"
/// HaveMenu : 1
/// Address : "رياض شارع المنصور"
/// Email : "ahmad@.com"
/// UserName : "aahh"
/// Password : "115599"
/// PhoneNumber : "09999"
/// CAID : 0
/// FaceBookToken : "AhmadAk"
/// InstagramToken : "AhmadAhy"
/// SFaceBookToken : "string"
/// SInstagramToken : "string"
/// SStatus : "pending"
/// CUID : 3056
/// City_En : "Riad      "

class Store_model {
  int _sid =0;
  String _nameAr ="";
  String _nameEn ="";
  String _descAr="";
  String _descEn="";
  double _lat=0;
  double _lng=0;
  String _photo="";
  int _status=0;
  double _rate=0;
  int _raters=0;
  String _cityAr="";
  String _openTime='';
  String _closeTime="";
  int _tax=0;
  double _taxAmount=0;
  String _timestamp="";
  int _haveMenu=0;
  String _address="";
  String _email="";
  String _userName="";
  String _password="";
  String _phoneNumber="";
  int _caid=0;
  String _faceBookToken="";
  String _instagramToken="";
  String _sFaceBookToken="";
  String _sInstagramToken="";
  String _sStatus="";
  int _cuid=0;
  String _cityEn="";

  int get sid => _sid;
  String get nameAr => _nameAr;
  String get nameEn => _nameEn;
  String get descAr => _descAr;
  String get descEn => _descEn;
  double get lat => _lat;
  double get lng => _lng;
  String get photo => _photo;
  int get status => _status;
  double get rate => _rate;
  int get raters => _raters;
  String get cityAr => _cityAr;
  String get openTime => _openTime;
  String get closeTime => _closeTime;
  int get tax => _tax;
  double get taxAmount => _taxAmount;
  String get timestamp => _timestamp;
  int get haveMenu => _haveMenu;
  String get address => _address;
  String get email => _email;
  String get userName => _userName;
  String get password => _password;
  String get phoneNumber => _phoneNumber;
  int get caid => _caid;
  String get faceBookToken => _faceBookToken;
  String get instagramToken => _instagramToken;
  String get sFaceBookToken => _sFaceBookToken;
  String get sInstagramToken => _sInstagramToken;
  String get sStatus => _sStatus;
  int get cuid => _cuid;
  String get cityEn => _cityEn;

  Store_model({
      int sid=0,
      String nameAr="",
      String nameEn="",
      String descAr="",
      String descEn="",
      double lat=0,
      double lng=0,
      String photo="",
      int status=0,
      double rate=0,
      int raters=0,
      String cityAr="",
      String openTime="",
      String closeTime="",
      int tax=0,
      double taxAmount=0,
      String timestamp="",
      int haveMenu=0,
      String address="",
      String email="",
      String userName="",
      String password="",
      String phoneNumber="",
      int caid=0,
      String faceBookToken="",
      String instagramToken="",
      String sFaceBookToken="",
      String sInstagramToken="",
      String sStatus="",
      int cuid=0,
      String cityEn=""}){
    _sid = sid;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _descAr = descAr;
    _descEn = descEn;
    _lat = lat;
    _lng = lng;
    _photo = photo;
    _status = status;
    _rate = rate;
    _raters = raters;
    _cityAr = cityAr;
    _openTime = openTime;
    _closeTime = closeTime;
    _tax = tax;
    _taxAmount = taxAmount;
    _timestamp = timestamp;
    _haveMenu = haveMenu;
    _address = address;
    _email = email;
    _userName = userName;
    _password = password;
    _phoneNumber = phoneNumber;
    _caid = caid;
    _faceBookToken = faceBookToken;
    _instagramToken = instagramToken;
    _sFaceBookToken = sFaceBookToken;
    _sInstagramToken = sInstagramToken;
    _sStatus = sStatus;
    _cuid = cuid;
    _cityEn = cityEn;
}

  Store_model.fromJson(dynamic json) {
    _sid = json["SID"];
    _nameAr = json["Name_Ar"];
    _nameEn = json["Name_En"];
    _descAr = json["Desc_Ar"];
    _descEn = json["Desc_En"];
    _lat = json["Lat"];
    _lng = json["Lng"];
    _photo = json["Photo"];
    _status = json["Status"];
    _rate = json["Rate"];
    _raters = json["Raters"];
    _cityAr = json["City_Ar"];
    _openTime = json["OpenTime"];
    _closeTime = json["CloseTime"];
    _tax = json["Tax"];
    _taxAmount = json["TaxAmount"];
    _timestamp = json["Timestamp"];
    _haveMenu = json["HaveMenu"];
    _address = json["Address"];
    _email = json["Email"];
    _userName = json["UserName"];
    _password = json["Password"];
    _phoneNumber = json["PhoneNumber"];
    _caid = json["CAID"];
    _faceBookToken = json["FaceBookToken"];
    _instagramToken = json["InstagramToken"];
    _sFaceBookToken = json["SFaceBookToken"];
    _sInstagramToken = json["SInstagramToken"];
    _sStatus = json["SStatus"];
    _cuid = json["CUID"];
    _cityEn = json["City_En"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["SID"] = _sid;
    map["Name_Ar"] = _nameAr;
    map["Name_En"] = _nameEn;
    map["Desc_Ar"] = _descAr;
    map["Desc_En"] = _descEn;
    map["Lat"] = _lat;
    map["Lng"] = _lng;
    map["Photo"] = _photo;
    map["Status"] = _status;
    map["Rate"] = _rate;
    map["Raters"] = _raters;
    map["City_Ar"] = _cityAr;
    map["OpenTime"] = _openTime;
    map["CloseTime"] = _closeTime;
    map["Tax"] = _tax;
    map["TaxAmount"] = _taxAmount;
    map["Timestamp"] = _timestamp;
    map["HaveMenu"] = _haveMenu;
    map["Address"] = _address;
    map["Email"] = _email;
    map["UserName"] = _userName;
    map["Password"] = _password;
    map["PhoneNumber"] = _phoneNumber;
    map["CAID"] = _caid;
    map["FaceBookToken"] = _faceBookToken;
    map["InstagramToken"] = _instagramToken;
    map["SFaceBookToken"] = _sFaceBookToken;
    map["SInstagramToken"] = _sInstagramToken;
    map["SStatus"] = _sStatus;
    map["CUID"] = _cuid;
    map["City_En"] = _cityEn;
    return map;
  }

}