


import 'package:yamams_market/service/model/service.dart';

class Services {
  List<Service>? _servs;

  Services({
    List<Service>?Servs
  })
  {
    this._servs = Servs;
    if(Servs==null){
      this._servs=<Service>[];
    }
  }
  List<Service> get servs => _servs!;
  set posts(List<Service> notss) => _servs = notss;

  factory Services.fromJson(List<dynamic> json) => Services(
      Servs: List<Service>.from(json.map((x) => Service.fromJson(x))));
}