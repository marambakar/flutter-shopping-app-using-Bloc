class odersView_model{
  String imageurl="";
  int pId=0;
  String name="";
  String dis="";
  double price=0;
  double totalPrice=0;
double quantity=0;
  bool check=false;
  String name_en ="";
  String dis_en="";
  odersView_model({required this.price,required this.dis,required this.name,required this.imageurl,required this.pId,required this.quantity,required this.totalPrice,required this.check,required this.dis_en,required this.name_en});



  odersView_model.fromJson(dynamic json) {
    imageurl = json["imageurl"];
    pId = json["pId"];
    name = json["name"];
    dis = json["dis"];
    price = json["price"];
    totalPrice = json["totalPrice"];
    quantity = json["quantity"];
    check = json["check"];
    name_en = json["name_en"];
    dis_en = json["dis_en"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["imageurl"] = imageurl;
    map["pId"] = pId;
    map["name"] = name;
    map["dis"] = dis;
    map["price"] = price;
    map["totalPrice"] = totalPrice;
    map["quantity"] = quantity;
    map["check"] = check;
    map["name_en"] = name_en;
    map["dis_en"] = dis_en;
    return map;
  }

}


