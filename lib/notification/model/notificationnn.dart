
class Notificationnn {
  int? _id;
  String? _headerEn;
  String? _contentEn;
  String? _photo;
  int? _receverID;
  String? _receverToken;
  String? _receverName;
  int? _senderID;
  String? _senderToken;
  String? _senderName;
  String? _timestamp;
  int? _status;
  String? _type;
  int? _readed;
  String? _headerAr;
  String? _contentAr;

  String? get headerEn => _headerEn;
  String? get contentEn => _contentEn;
  String? get photo => _photo;
  int? get receverID => _receverID;
  String? get receverToken => _receverToken;
  String? get receverName => _receverName;
  int? get senderID => _senderID;
  String? get senderToken => _senderToken;
  String? get senderName => _senderName;
  String? get timestamp => _timestamp;
  int? get status => _status;
  String? get type => _type;
  int? get readed => _readed;
  String? get headerAr => _headerAr;
  String? get contentAr => _contentAr;

  Notificationnn({
    int? id,
      String? headerEn, 
      String? contentEn, 
      String? photo, 
      int? receverID, 
      String? receverToken, 
      String? receverName, 
      int? senderID, 
      String? senderToken, 
      String? senderName, 
      String? timestamp, 
      int? status, 
      String? type, 
      int? readed, 
      String? headerAr, 
      String? contentAr}){
    _id=id;
    _headerEn = headerEn;
    _contentEn = contentEn;
    _photo = photo;
    _receverID = receverID;
    _receverToken = receverToken;
    _receverName = receverName;
    _senderID = senderID;
    _senderToken = senderToken;
    _senderName = senderName;
    _timestamp = timestamp;
    _status = status;
    _type = type;
    _readed = readed;
    _headerAr = headerAr;
    _contentAr = contentAr;
}

  Notificationnn.fromJson(dynamic json) {
    _id=json["ANID"];
    _headerEn = json["Header_En"];
    _contentEn = json["Content_En"];
    _photo = json["Photo"];
    _receverID = json["ReceverID"];
    _receverToken = json["ReceverToken"];
    _receverName = json["ReceverName"];
    _senderID = json["SenderID"];
    _senderToken = json["SenderToken"];
    _senderName = json["SenderName"];
    _timestamp = json["Timestamp"];
    _status = json["Status"];
    _type = json["Type"];
    _readed = json["Readed"];
    _headerAr = json["Header_Ar"];
    _contentAr = json["Content_Ar"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ANID"]=_id;
    map["Header_En"] = _headerEn;
    map["Content_En"] = _contentEn;
    map["Photo"] = _photo;
    map["ReceverID"] = _receverID;
    map["ReceverToken"] = _receverToken;
    map["ReceverName"] = _receverName;
    map["SenderID"] = _senderID;
    map["SenderToken"] = _senderToken;
    map["SenderName"] = _senderName;
    map["Timestamp"] = _timestamp;
    map["Status"] = _status;
    map["Type"] = _type;
    map["Readed"] = _readed;
    map["Header_Ar"] = _headerAr;
    map["Content_Ar"] = _contentAr;
    return map;
  }

  set receverName(String? value) {
    _receverName = value;
  }

  int get id => _id!;

  set id(int value) {
    _id = value;
  }

  set senderToken(String? value) {
    _senderToken = value;
  }

  set readed(int? value) {
    _readed = value;
  }
}