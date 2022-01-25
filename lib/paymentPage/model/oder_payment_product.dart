import 'package:yamams_market/orderPage/order_model.dart';
import 'package:yamams_market/paymentPage/model/acount.dart';


class Oder_payment_product {
  List<Order_model>? _addOrderProductViewModel;
  AddorderViewModel? _addorderViewModel;
  Acount? _addPaymentViewModel;

  List<Order_model>? get addOrderProductViewModel => _addOrderProductViewModel;
  AddorderViewModel? get addorderViewModel => _addorderViewModel;
  Acount? get addPaymentViewModel => _addPaymentViewModel;

  Oder_payment_product({
      List<Order_model>? addOrderProductViewModel,
      AddorderViewModel? addorderViewModel,
    Acount? addPaymentViewModel}){
    _addOrderProductViewModel = addOrderProductViewModel;
    _addorderViewModel = addorderViewModel;
    _addPaymentViewModel = addPaymentViewModel;
}

  set addOrderProductViewModel(List<Order_model>? value) {
    _addOrderProductViewModel = value;
  }

  Oder_payment_product.fromJson(dynamic json) {
    if (json["addOrderProductViewModel"] == null) {
      _addOrderProductViewModel = [];
      json["addOrderProductViewModel"].forEach((v) {
        _addOrderProductViewModel?.add(Order_model.fromJson(v));
      });
    }
    _addorderViewModel = json["addorderViewModel"] != null ? AddorderViewModel.fromJson(json["addorderViewModel"]) : null;
    _addPaymentViewModel = json["addPaymentViewModel"] != null ? Acount.fromJson(json["addPaymentViewModel"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_addOrderProductViewModel != null) {
      map["addOrderProductViewModel"] = _addOrderProductViewModel?.map((v) => v.toJson()).toList();
    }
    if (_addorderViewModel != null) {
      map["addorderViewModel"] = _addorderViewModel?.toJson();
    }
    if (_addPaymentViewModel != null) {
      map["addPaymentViewModel"] = _addPaymentViewModel?.toJson();
    }
    return map;
  }

  set addorderViewModel(AddorderViewModel? value) {
    _addorderViewModel = value;
  }

  set addPaymentViewModel(Acount? value) {
    _addPaymentViewModel = value;
  }
}







class AddorderViewModel {
  int? _cuid;
  String? _timeStamp;
  String? _orderNumber;
  int? _shid;

  set cuid(int? value) {
    _cuid = value;
  }

  int? _total;
  int? _coupone;
  String? _couponeName;
  int? _status;
  int? _fTotla;
  String? _tracking;
  String? _notes;
  String? _details;

  int? get cuid => _cuid;
  String? get timeStamp => _timeStamp;
  String? get orderNumber => _orderNumber;
  int? get shid => _shid;
  int? get total => _total;
  int? get coupone => _coupone;
  String? get couponeName => _couponeName;
  int? get status => _status;
  int? get fTotla => _fTotla;
  String? get tracking => _tracking;
  String? get notes => _notes;
  String? get details => _details;

  AddorderViewModel({
      int? cuid, 
      String? timeStamp, 
      String? orderNumber, 
      int? shid, 
      int? total, 
      int? coupone, 
      String? couponeName, 
      int? status, 
      int? fTotla, 
      String? tracking, 
      String? notes, 
      String? details}){
    _cuid = cuid;
    _timeStamp = timeStamp;
    _orderNumber = orderNumber;
    _shid = shid;
    _total = total;
    _coupone = coupone;
    _couponeName = couponeName;
    _status = status;
    _fTotla = fTotla;
    _tracking = tracking;
    _notes = notes;
    _details = details;
}

  AddorderViewModel.fromJson(dynamic json) {
    _cuid = json["CUID"];
    _timeStamp = json["TimeStamp"];
    _orderNumber = json["OrderNumber"];
    _shid = json["SHID"];
    _total = json["Total"];
    _coupone = json["Coupone"];
    _couponeName = json["CouponeName"];
    _status = json["Status"];
    _fTotla = json["FTotla"];
    _tracking = json["Tracking"];
    _notes = json["Notes"];
    _details = json["Details"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["CUID"] = _cuid;
    map["TimeStamp"] = _timeStamp;
    map["OrderNumber"] = _orderNumber;
    map["SHID"] = _shid;
    map["Total"] = _total;
    map["Coupone"] = _coupone;
    map["CouponeName"] = _couponeName;
    map["Status"] = _status;
    map["FTotla"] = _fTotla;
    map["Tracking"] = _tracking;
    map["Notes"] = _notes;
    map["Details"] = _details;
    return map;
  }

  set timeStamp(String? value) {
    _timeStamp = value;
  }

  set orderNumber(String? value) {
    _orderNumber = value;
  }

  set shid(int? value) {
    _shid = value;
  }

  set total(int? value) {
    _total = value;
  }

  set coupone(int? value) {
    _coupone = value;
  }

  set couponeName(String? value) {
    _couponeName = value;
  }

  set status(int? value) {
    _status = value;
  }

  set fTotla(int? value) {
    _fTotla = value;
  }

  set tracking(String? value) {
    _tracking = value;
  }

  set notes(String? value) {
    _notes = value;
  }

  set details(String? value) {
    _details = value;
  }
}



