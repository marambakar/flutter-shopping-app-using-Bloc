

class Service {
  String? Name="";
  String? pContent="";
  String type="";
 double Price=0.0;
String? file;


  Service({
    String?  Name="",
    String? pContent="",
    String type="",
    double Price=0.0,
    String? file
  }) {
   this.Name=Name;
    this.pContent = pContent;
    this.type=type;
    this.Price=Price;
    this.file=file;



  }



  Service.fromJson(dynamic json) {
 Name=json["Title"];
    pContent = json["PContent"];
    type=json["Type"];
    Price=json["Price"];
    file=json["File"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
   map["Title"]=Name;
    map["PContent"] = pContent;
    map["Type"]=type;
    map["Price"]=Price;
    map["File"]=file;

    return map;
  }



}