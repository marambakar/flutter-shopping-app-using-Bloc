

class Link {
  int? _sid;
  String? _storeUrl;
  int _status=1;
  String? _timeStamp;
  int? _cuid;
  String? _descriptionAr;
  String? _descriptionEn;
  String? _name;

  int? get sid => _sid;
  String? get storeUrl => _storeUrl;
  int? get status => _status;
  String? get timeStamp => _timeStamp;
  int? get cuid => _cuid;
  String? get descriptionAr => _descriptionAr;
  String? get descriptionEn => _descriptionEn;
  String? get name => _name;

  Link({
      int? sid, 
      String? storeUrl, 
      int status=1,
      String? timeStamp, 
      int? cuid, 
      String? descriptionAr, 
      String? descriptionEn, 
      String? name}){
    _sid = sid;
    _storeUrl = storeUrl;
    _status = status;
    _timeStamp = timeStamp;
    _cuid = cuid;
    _descriptionAr = descriptionAr;
    _descriptionEn = descriptionEn;
    _name = name;
}

  Link.fromJson(dynamic json) {
    _sid = json["SID"];
    _storeUrl = json["LinkUrl"];
    _status = json["Status"];
    _timeStamp = json["TimeStamp"];
    _cuid = json["CUID"];
    _descriptionAr = json["Description_Ar"];
    _descriptionEn = json["Description_En"];
    _name = json["Name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["SID"] = _sid;
    map["LinkUrl"] = _storeUrl;
    map["Status"] = _status;
    map["TimeStamp"] = _timeStamp;
    map["CUID"] = _cuid;
    map["Description_Ar"] = _descriptionAr;
    map["Description_En"] = _descriptionEn;
    map["Name"] = _name;
    return map;
  }

}