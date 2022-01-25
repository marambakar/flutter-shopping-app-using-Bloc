

class Advertisment_model {
  int _adid=0;
  String _nameAr='';
  String _nameEn='';
  dynamic _descriptionAr;
  dynamic _descriptionEn;
  int _status=0;
  String _timeStamp='';
  String _startDate='';
  String _enddate='';
  int _caid=0;
  double _lat=0;
  double _lang=0;
  dynamic _city;
  String _Photo='';
  int get adid => _adid;
  String get nameAr => _nameAr;
  String get  Photo => _Photo;
  String get nameEn => _nameEn;
  dynamic get descriptionAr => _descriptionAr;
  dynamic get descriptionEn => _descriptionEn;
  int get status => _status;
  String get timeStamp => _timeStamp;
  String get startDate => _startDate;
  String get enddate => _enddate;
  int get caid => _caid;
  double get lat => _lat;
  double get lang => _lang;
  dynamic get city => _city;

  Advertisment_model({
    int adid=0,
    String nameAr='',
    String nameEn='',
    dynamic descriptionAr,
    dynamic descriptionEn,
    int status=0,
    String timeStamp='',
    String startDate='',
    String enddate='',
    int caid=0,
    String Photo='',
    double lat=0,
    double lang=0,
    dynamic city}){
    _adid = adid;
    _Photo = Photo;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _descriptionAr = descriptionAr;
    _descriptionEn = descriptionEn;
    _status = status;
    _timeStamp = timeStamp;
    _startDate = startDate;
    _enddate = enddate;
    _caid = caid;
    _lat = lat;
    _lang = lang;
    _city = city;
  }

  Advertisment_model.fromJson(dynamic json) {
    _Photo = json["Photo"];
    _adid = json["ADID"];
    _nameAr = json["NameAr"];
    _nameEn = json["NameEn"];
    _descriptionAr = json["DescriptionAr"];
    _descriptionEn = json["DescriptionEn"];
    _status = json["Status"];
    _timeStamp = json["TimeStamp"];
    _startDate = json["StartDate"];
    _enddate = json["Enddate"];
    _caid = json["CAID"];
    _lat = json["Lat"];
    _lang = json["Lang"];
    _city = json["City"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Photo"] = _Photo;
    map["ADID"] = _adid;
    map["NameAr"] = _nameAr;
    map["NameEn"] = _nameEn;
    map["DescriptionAr"] = _descriptionAr;
    map["DescriptionEn"] = _descriptionEn;
    map["Status"] = _status;
    map["TimeStamp"] = _timeStamp;
    map["StartDate"] = _startDate;
    map["Enddate"] = _enddate;
    map["CAID"] = _caid;
    map["Lat"] = _lat;
    map["Lang"] = _lang;
    map["City"] = _city;
    return map;
  }

}