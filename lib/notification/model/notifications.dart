

import 'package:yamams_market/notification/model/notificationnn.dart';

class Notifications {
  List<Notificationnn>? _Nots;

  Notifications({
    List<Notificationnn>?Nots
  })
  {
    this._Nots = Nots;
    if(Nots==null){
      this._Nots=<Notificationnn>[] ;
    }
  }
  List<Notificationnn> get nots => _Nots!;
  set posts(List<Notificationnn> notss) => _Nots = notss;

  factory Notifications.fromJson(List<dynamic> json) => Notifications(
      Nots: List<Notificationnn>.from(json.map((x) => Notificationnn.fromJson(x))));


  List toJson() {
    List jsonList = [];
    nots.map((item) =>
        jsonList.add(item.toJson())
    ).toList();
    return jsonList;
  }
}