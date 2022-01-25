/// PRID : 2032
/// CAID : 0
/// NameAr : "بوط رياضي"
/// NameEn : "sport shoe"
/// DescriptionAr : "بوط رياضي نوع اول مناسبب للركد لمسافات طويلة"
/// Status : 1
/// TimeStamp : "2021-09-26T22:29:32.587"
/// FavoriteCount : 0
/// Lat : 0
/// Lang : 0
/// CUID : 0
/// SID : 1003
/// Photo : "yamamstore.fingerprint.ml\\images\\2032_Product_qw.jpg"
/// Price : 150

class Favourite_model {
  int _prid=0;
  int _caid=0;
  String _nameAr="";
  String _nameEn="";
  String _descriptionAr="";
  int _status=0;
  String _timeStamp="";
  int _favoriteCount=0;
  double _lat=0;
  double _lang=0;
  int _cuid=0;
  int _sid=0;
  String _photo="";
  double _price=0;

  int get prid => _prid;
  int get caid => _caid;
  String get nameAr => _nameAr;
  String get nameEn => _nameEn;
  String get descriptionAr => _descriptionAr;
  int get status => _status;
  String get timeStamp => _timeStamp;
  int get favoriteCount => _favoriteCount;
  double get lat => _lat;
  double get lang => _lang;
  int get cuid => _cuid;
  int get sid => _sid;
  String get photo => _photo;
  double get price => _price;

  Favourite_model({
      int prid=0,
      int caid=0,
      String nameAr="",
      String nameEn="",
      String descriptionAr="",
      int status=0,
      String timeStamp="",
      int favoriteCount=0,
      double lat=0,
      double lan=0,
      int cuid=0,
      int sid=0,
      String photo="",
      double price=0}){
    _prid = prid;
    _caid = caid;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _descriptionAr = descriptionAr;
    _status = status;
    _timeStamp = timeStamp;
    _favoriteCount = favoriteCount;
    _lat = lat;
    _lang = lang;
    _cuid = cuid;
    _sid = sid;
    _photo = photo;
    _price = price;
}

  Favourite_model.fromJson(dynamic json) {
    _prid = json["PRID"];
    _caid = json["CAID"];
    _nameAr = json["NameAr"];
    _nameEn = json["NameEn"];
    _descriptionAr = json["DescriptionAr"];
    _status = json["Status"];
    _timeStamp = json["TimeStamp"];
    _favoriteCount = json["FavoriteCount"];
    _lat = json["Lat"];
    _lang = json["Lang"];
    _cuid = json["CUID"];
    _sid = json["SID"];
    _photo = json["Photo"];
    _price = json["Price"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["PRID"] = _prid;
    map["CAID"] = _caid;
    map["NameAr"] = _nameAr;
    map["NameEn"] = _nameEn;
    map["DescriptionAr"] = _descriptionAr;
    map["Status"] = _status;
    map["TimeStamp"] = _timeStamp;
    map["FavoriteCount"] = _favoriteCount;
    map["Lat"] = _lat;
    map["Lang"] = _lang;
    map["CUID"] = _cuid;
    map["SID"] = _sid;
    map["Photo"] = _photo;
    map["Price"] = _price;
    return map;
  }

}