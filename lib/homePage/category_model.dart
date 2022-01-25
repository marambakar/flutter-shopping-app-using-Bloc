/// CAID : 1
/// NameAr : "عصائر"
/// NameEn : "juices"
/// DescriptionAr : "string"
/// DescriptionEn : "string"
/// Status : 1
/// TimeStamp : "2021-08-24T12:43:07.567"
/// SID : null
/// Photo : null

class Category_model {
  int _caid = 0;
  String _nameAr = '';
  String _nameEn = '';
  String _descriptionAr ='';
  String _descriptionEn='';
  int _status = 0;
  String _timeStamp = '';
  dynamic _sid;

  set caid(int value) {
    _caid = value;
  }

  dynamic _photo;

  int get caid => _caid;
  String get nameAr => _nameAr;
  String get nameEn => _nameEn;
  String get descriptionAr => _descriptionAr;
  String get descriptionEn => _descriptionEn;
  int get status => _status;
  String get timeStamp => _timeStamp;
  dynamic get sid => _sid;
  dynamic get photo => _photo;

  Category_model({
    int caid = 0,
    String nameAr = '',
    String nameEn = '',
    String descriptionAr = '',
    String descriptionEn = '',
    int status = 0,
    String timeStamp = '',
    dynamic sid,
    dynamic photo}){
    _caid = caid;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _descriptionAr = descriptionAr;
    _descriptionEn = descriptionEn;
    _status = status;
    _timeStamp = timeStamp;
    _sid = sid;
    _photo = photo;
  }

  Category_model.fromJson(dynamic json) {
    _caid = json["CAID"];
    _nameAr = json["NameAr"];
    _nameEn = json["NameEn"];
    _descriptionAr = json["DescriptionAr"];
    _descriptionEn = json["DescriptionEn"];
    _status = json["Status"];
    _timeStamp = json["TimeStamp"];
    _sid = json["SID"];
    _photo = json["Photo"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["CAID"] = _caid;
    map["NameAr"] = _nameAr;
    map["NameEn"] = _nameEn;
    map["DescriptionAr"] = _descriptionAr;
    map["DescriptionEn"] = _descriptionEn;
    map["Status"] = _status;
    map["TimeStamp"] = _timeStamp;
    map["SID"] = _sid;
    map["Photo"] = _photo;
    return map;
  }

  set nameAr(String value) {
    _nameAr = value;
  }

  set nameEn(String value) {
    _nameEn = value;
  }

  set descriptionAr(String value) {
    _descriptionAr = value;
  }

  set descriptionEn(String value) {
    _descriptionEn = value;
  }

  set status(int value) {
    _status = value;
  }

  set timeStamp(String value) {
    _timeStamp = value;
  }

  set sid(dynamic value) {
    _sid = value;
  }

  set photo(dynamic value) {
    _photo = value;
  }
}