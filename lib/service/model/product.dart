

class Product {
  int _prid=0;
  int _caid=0;
  String _nameAr="";
  String _nameEn="";
  String _descriptionAr="";
  String _descriptionEn="";
  int _status=1;
  String _timeStamp="";
  int _favoriteCount=0;
  double _lat=0;
  double _lang=0;
  String _city="";
  int _cuid=0;
  int _sid=0;
  String _photo="";
 double _price=0;
 String type="";

  set prid(int value) {
    _prid = value;
  }

  int get prid => _prid;
  int get caid => _caid;
  String get nameAr => _nameAr;
  String get nameEn => _nameEn;
  String get descriptionAr => _descriptionAr;
  String get descriptionEn => _descriptionEn;
  int get status => _status;
  String get timeStamp => _timeStamp;
  int get favoriteCount => _favoriteCount;
  double get lat => _lat;
  double get lang => _lang;
 String get city => _city;
  int get cuid => _cuid;
  int get sid => _sid;
  String get photo => _photo;
  double get price => _price;

  Product({
      int prid=0,
      int caid=0,
      String nameAr="",
      String nameEn="",
      String descriptionAr="",
     String descriptionEn="",
      int status=1,
      String timeStamp="",
      int favoriteCount=0,
      double lat=0,
      double lang=0,
      String city="",
      int cuid=0,
      int sid=0,
      String photo="",
      double price=0,
    String type="",
  }){
    _prid = prid;
    _caid = caid;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _descriptionAr = descriptionAr;
    _descriptionEn = descriptionEn;
    _status = status;
    _timeStamp = timeStamp;
    _favoriteCount = favoriteCount;
    _lat = lat;
    _lang = lang;
    _city = city;
    _cuid = cuid;
    _sid = sid;
    _photo = photo;
    _price = price;
    this.type=type;
}

  Product.fromJson(dynamic json) {
    _prid = json["PRID"];
    _caid = json["CAID"];
    _nameAr = json["NameAr"];
    _nameEn = json["NameEn"];
    _descriptionAr = json["DescriptionAr"];
    _descriptionEn = json["DescriptionEn"];
    _status = json["Status"];
    _timeStamp = json["TimeStamp"];
    _favoriteCount = json["FavoriteCount"];
    _lat = json["Lat"];
    _lang = json["Lang"];
    _city = json["City"];
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
    map["DescriptionEn"] = _descriptionEn;
    map["Status"] = _status;
    map["TimeStamp"] = _timeStamp;
    map["FavoriteCount"] = _favoriteCount;
    map["Lat"] = _lat;
    map["Lang"] = _lang;
    map["City"] = _city;
    map["CUID"] = _cuid;
    map["SID"] = _sid;
    map["Photo"] = _photo;
    map["Price"] = _price;
    return map;
  }

  set caid(int value) {
    _caid = value;
  }

  set price(double value) {
    _price = value;
  }

  set photo(String value) {
    _photo = value;
  }

  set sid(int value) {
    _sid = value;
  }

  set cuid(int value) {
    _cuid = value;
  }

  set city(String value) {
    _city = value;
  }

  set lang(double value) {
    _lang = value;
  }

  set lat(double value) {
    _lat = value;
  }

  set favoriteCount(int value) {
    _favoriteCount = value;
  }

  set timeStamp(String value) {
    _timeStamp = value;
  }

  set status(int value) {
    _status = value;
  }

  set descriptionEn(String value) {
    _descriptionEn = value;
  }

  set descriptionAr(String value) {
    _descriptionAr = value;
  }

  set nameEn(String value) {
    _nameEn = value;
  }

  set nameAr(String value) {
    _nameAr = value;
  }
}