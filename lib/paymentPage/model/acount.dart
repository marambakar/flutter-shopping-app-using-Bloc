/// CUID : 0
/// Type : "string"
/// CardHolder : "string"
/// CardNumber : "string"
/// ValidDate : "2021-09-19T11:59:15.609Z"
/// CVC : "string"
/// SecurityCode : "string"
/// Status : 0
/// TimeStamp : "2021-09-19T11:59:15.609Z"
/// Amount : 0

class Acount {
  int  _ACID=0;
  int? _cuid;
  String? _type;
  String? _cardHolder;
  String? _cardNumber;
  String? _validDate;
  String? _cvc;
  String? _securityCode;
  int? _status;
  String? _timeStamp;
  double? _amount;
  int? _orid;
  int? get cuid => _cuid;
  String? get type => _type;
  String? get cardHolder => _cardHolder;
  String? get cardNumber => _cardNumber;
  String? get validDate => _validDate;
  String? get cvc => _cvc;
  String? get securityCode => _securityCode;
  int? get status => _status;
  String? get timeStamp => _timeStamp;
  double? get amount => _amount;

  Acount({
    int  ACID=0,
      int? cuid, 
      String? type, 
      String? cardHolder, 
      String? cardNumber, 
      String? validDate, 
      String? cvc, 
      String? securityCode, 
      int? status, 
      String? timeStamp, 
      double? amount,
    int? orid,
  }){
    _ACID=ACID;
    _cuid = cuid;
    _type = type;
    _cardHolder = cardHolder;
    _cardNumber = cardNumber;
    _validDate = validDate;
    _cvc = cvc;
    _securityCode = securityCode;
    _status = status;
    _timeStamp = timeStamp;
    _amount = amount;
    _orid=orid;
}

  Acount.fromJson(dynamic json) {
    _ACID=json[ "ACID"];
    _cuid = json["CUID"];
    _type = json["Type"];
    _cardHolder = json["CardHolder"];
    _cardNumber = json["CardNumber"];
    _validDate = json["ValidDate"];
    _cvc = json["CVC"];
    _securityCode = json["SecurityCode"];
    _status = json["Status"];
    _timeStamp = json["TimeStamp"];
    _amount = json["Amount"];
    _orid=json["ORID"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ACID"]=_ACID;
    map["ORID"]=_orid;
    map["CUID"] = _cuid;
    map["Type"] = _type;
    map["CardHolder"] = _cardHolder;
    map["CardNumber"] = _cardNumber;
    map["ValidDate"] = _validDate;
    map["CVC"] = _cvc;
    map["SecurityCode"] = _securityCode;
    map["Status"] = _status;
    map["TimeStamp"] = _timeStamp;
    map["Amount"] = _amount;
    return map;
  }

  set cuid(int? value) {
    _cuid = value;
  }

  int get ACID => _ACID;

  set ACID(int? value) {
    _ACID = value!;
  }

  set type(String? value) {
    _type = value;
  }

  set cardHolder(String? value) {
    _cardHolder = value;
  }

  set cardNumber(String? value) {
    _cardNumber = value;
  }

  set validDate(String? value) {
    _validDate = value;
  }

  set cvc(String? value) {
    _cvc = value;
  }

  set securityCode(String? value) {
    _securityCode = value;
  }

  set status(int? value) {
    _status = value;
  }

  set timeStamp(String? value) {
    _timeStamp = value;
  }

  set amount(double? value) {
    _amount = value;
  }

  int? get orid => _orid;

  set orid(int? value) {
    _orid = value;
  }
}