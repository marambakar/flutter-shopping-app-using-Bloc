
class Order_model {
  int _opid=0;
  int _prid=0;
  int _orid=0;
  double _quantity=0;
  double _total=0;
  int _taxable=0;
  double _taxNumber=0;
  int _discount=0;
  double _discountNumber=0;
  double _fTotal=0;
  String _timestamp="";
  int _status=0;
  String _orderNumber="";

  int get opid => _opid;
  int get prid => _prid;
  int get orid => _orid;
  double get quantity => _quantity;
  double get total => _total;
  int get taxable => _taxable;
  double get taxNumber => _taxNumber;
  int get discount => _discount;
  double get discountNumber => _discountNumber;
  double get fTotal => _fTotal;
  String get timestamp => _timestamp;
  int get status => _status;
  String get orderNumber => _orderNumber;


  Order_model({
    int opid = 0,
    int prid = 0,
    int orid =0,
    double quantity =0,
    double total = 0,
    int taxable =0,
    double taxNumber =0,
    int discount =0,
    double discountNumber=0,
    double fTotal =0,
    String timestamp ="",
    int status =0,
    String orderNumber =""}){
    _opid = opid;
    _prid = prid;
    _orid = orid;
    _quantity = quantity;
    _total = total;
    _taxable = taxable;
    _taxNumber = taxNumber;
    _discount = discount;
    _discountNumber = discountNumber;
    _fTotal = fTotal;
    _timestamp = timestamp;
    _status = status;
    _orderNumber = orderNumber;
  }
  void set total(double total) {
    this._total = total;
  }
  void set prid(int productid) {
    this._prid = productid;
  }
  void set quantity(double quantityy) {
    this._quantity = quantityy;
  }
  Order_model.fromJson(dynamic json) {
    _opid = json["OPID"];
    _prid = json["PRID"];
    _orid = json["ORID"];
    _quantity = json["Quantity"];
    _total = json["Total"];
    _taxable = json["Taxable"];
    _taxNumber = json["TaxNumber"];
    _discount = json["Discount"];
    _discountNumber = json["DiscountNumber"];
    _fTotal = json["FTotal"];
    _timestamp = json["Timestamp"];
    _status = json["Status"];
    _orderNumber = json["OrderNumber"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["OPID"] = _opid;
    map["PRID"] = _prid;
    map["ORID"] = _orid;
    map["Quantity"] = _quantity;
    map["Total"] = _total;
    map["Taxable"] = _taxable;
    map["TaxNumber"] = _taxNumber;
    map["Discount"] = _discount;
    map["DiscountNumber"] = _discountNumber;
    map["FTotal"] = _fTotal;
    map["Timestamp"] = _timestamp;
    map["Status"] = _status;
    map["OrderNumber"] = _orderNumber;
    return map;
  }

}