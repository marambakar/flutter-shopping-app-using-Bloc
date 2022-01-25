

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:yamams_market/Splash/splash_screen.dart';
import 'package:yamams_market/homePage/category_model.dart';
import 'package:yamams_market/myProfile/bloc_profile.dart';
import 'package:yamams_market/myProfile/store_request.dart';
import 'package:yamams_market/regeister/model/customer.dart';
import 'dart:io';

import 'package:yamams_market/service/block_sevice.dart';
import 'package:yamams_market/service/model/product.dart';
import 'package:yamams_market/sitting/sitting_screen.dart';
import 'package:yamams_market/sitting/wiedget/buttum_wedget.dart';
import 'package:easy_localization/src/public_ext.dart';


class CustomerProfile extends StatefulWidget {
   Customer cus=SplashScreen.user.customer;
  CustomerProfile();
  static  List<Category_model> tempList=[];
  @override
  CustomerProfileBody createState() => CustomerProfileBody();
  ProfileBloc ser = new ProfileBloc();
}

class CustomerProfileBody extends State<CustomerProfile> {

  @override
  initState() {
    super.initState();
    StateProfie.singleton.customer=widget.cus;
   widget.ser.stateProfileController.sink.add(  StateProfie.singleton);
    widget.ser.eventProfileController.sink.add(new addAdress(LocTex: ''));
    print("hiiiiiiiiiiiiiiiii");

  }

  double widthscreen = 0, heightscreen = 0;


  int gender=0;

  TextEditingController gennder = new TextEditingController();
  TextEditingController Namee = new TextEditingController();
  TextEditingController Locationn = new TextEditingController();
  AsyncSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;
    return Scaffold(
       extendBody: true,
        appBar: AppBar(
            elevation: 0,
            leading: Container(),
            actions: [],
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              "My Profile".tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            )),
        body: StreamBuilder(
            stream: widget.ser.stateProfileController.stream,
            //output stream (Counetr)
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              this.snapshot=snapshot;
              if(snapshot.hasData)
                {
                  print("snapshot.data.customer.dateOfBirth"+snapshot.data.customer.dateOfBirth);
                  return SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: widthscreen,
                              height: heightscreen/7,
                              margin: EdgeInsets.only(right: widthscreen/22,left: widthscreen/22,top: widthscreen/21),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft:Radius.circular(20)  )  ,
                                color: Color(0xff7f92a7),
                              ),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data!=null?snapshot.data.customer.userName:"",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Row(children: [
                                      Text(
                                        snapshot.data.customer.city!=null?snapshot.data.customer.city:"City",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),

                                      Icon(Icons.location_on,color: Colors.white,)
                                    ],)


                                  ],),
                                subtitle: Row(

                                  children: [
                                    Text(
                                     snapshot.data==null?"0":snapshot.data.balance==null?"0":snapshot.data.balance,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "balance",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],),
                              ),
                            ),
                            Container(
                              width: widthscreen,
                              height: heightscreen/11,
                              margin: EdgeInsets.only(right: widthscreen/22,left: widthscreen/22,bottom: widthscreen/33),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight:Radius.circular(20)) ,
                                color: Color(0xff3e4253),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  IconButton(
                                    icon: Image.asset("images/not.png",width:widthscreen/18,height: widthscreen/18,),
                                    onPressed: () {
                                      print("ok");

                                    },
                                  ),
                                  IconButton(
                                    icon: Image.asset("images/balance.png",width:widthscreen/18,height: widthscreen/18,),
                                    onPressed: () {
                                      print("ok");

                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.favorite_border,color: Colors.white,size: widthscreen/15,),
                                    onPressed: () {
                                      print("ok");

                                    },
                                  ),
                                ],),
                            ),
                            Container(
                              width: widthscreen,
                              padding: EdgeInsets.only(top: heightscreen/44),
                              margin: EdgeInsets.all(widthscreen/21),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(color: Color(0xff7f92a7), width: 2, ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                color: Colors.white,
                              ),

                              child:
                              Column (children: [    WedgetButtom(text: "Name".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine:true,Textalarm: snapshot.data!=null?snapshot.data.customer.userName==null?"":snapshot.data.customer.userName:"",method: methodName,),
                                WedgetButtom(text: "gender".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine:true,Textalarm: snapshot.data!=null?snapshot.data.customer.gender==null?"":snapshot.data.customer.gender==1?"female":"Male":"",method: methodGender,),
                                WedgetButtom(text: "birthday".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine:true,Textalarm:snapshot.data!=null?snapshot.data.customer.dateOfBirth==""?"":DateFormat('yyyy-MM-dd', "en_US").format(DateTime.parse(snapshot.data.customer.dateOfBirth)):"",method: methodBirthday,),
                                WedgetButtom(text: "Address".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine:true,Textalarm:snapshot.data!=null?snapshot.data.customer.city==null?"":snapshot.data.customer.city:"",method: methodAdress,),
                                WedgetButtom(text: "Bayment".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine:true,Textalarm: ""),
                                WedgetButtom(text: "services".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine:true,Textalarm: ""),
                                WedgetButtom(text: "Request a seller's license".tr(),iconData: Icons.arrow_forward_ios_rounded,isLine:false,Textalarm: "",method:methodStoreReq),
                              ]
                              ),

                            ),
                          ])
                  );
                }
              else
                {
                  return Container();
                }

            }));
  }

 methodGender()
{
  Dialog simpleDialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child:
    Container(
      height:heightscreen/8,


      // child: ToggleSwitch(
      //   minWidth: widthscreen/3,
      //
      //   initialLabelIndex: 0,
      //   cornerRadius: 1,
      //   borderWidth: 2,
      //   activeFgColor: Colors.white,
      //   inactiveBgColor: Colors.white,
      //   inactiveFgColor: Colors.black,
      //   totalSwitches: 2,
      //   labels: ['male', 'female'],
      //   icons: [
      //     FontAwesomeIcons.mars,
      //     FontAwesomeIcons.venus
      //   ],
      //   activeBgColors:[[Color(0xff7f92a7),],[Color(0xff7f92a7)]],
      //
      //   onToggle: (index) {
      //     print('switched to: $index');
      //     gennder.text=index.toString();
      //
      //   },
      // ),
      child:getWidget(false,false),
    ),

    clipBehavior: Clip.antiAlias,
  );
  showDialog(
      context: context, builder: (BuildContext context) => simpleDialog);
}

  methodName()
  {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child:
      Container(
        height: heightscreen/6,
          padding: EdgeInsets.symmetric(horizontal: widthscreen/22),
        child: Column(children: [
          TextFormField(
              textAlign: TextAlign.start,
              controller: Namee,
              onChanged: (value) {

              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: widget.cus.userName,

              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            RaisedButton(
              color: Color(0xff7f92a7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child:Text("confirm",style: TextStyle(fontSize: 12),),
                onPressed:() {
                print("ok");
                widget.cus.userName=Namee.text;
                    widget.ser.eventProfileController.sink.add(new EdetCustomer(customer:widget.cus ));
                Navigator.pop(context);

                }
            ),
            RaisedButton(
              color: Color(0xff7f92a7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child:Text("cancel",style: TextStyle(fontSize: 12),),
                onPressed:() {
                print("cancel");
                Navigator.pop(context);

              }
            )
          ],)

        ],)

      ),

      clipBehavior: Clip.antiAlias,
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  methodBirthday()
  async {
    DateTime? newDateTime = await showDatePicker(

      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1960),
      lastDate: DateTime(2001),
      // height: heightscreen/3.5,


   builder:  (BuildContext context, Widget? child)  {

        return Theme(
          data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xff7f92a7), // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Colors.black45, // body text color
              ),
          ),
          child: child!,
        );
      },

    );

    widget.cus.dateOfBirth= newDateTime.toString();
    widget.ser.eventProfileController.sink.add(new EdetCustomer(customer:widget.cus ));
  }

  methodAdress()
  async {
       widget.cus.city=snapshot!.data.TextLoc.split(',').last;
       print("gggggggggggggg"+snapshot!.data.TextLoc.toString());
     Dialog simpleDialog = Dialog(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(12.0),
       ),
       child:   Container(
         margin: EdgeInsets.only(top:heightscreen/22),
           height: heightscreen/6,
           padding: EdgeInsets.symmetric(horizontal: widthscreen/22),
           child: Column(children: [
            Expanded(
               child: Text(this.snapshot!.data==null?"":this.snapshot!.data.TextLoc
             ),),

             Container(
               height: heightscreen/18,
               padding: EdgeInsets.only(bottom: heightscreen/55),
                 child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 RaisedButton(
                     color: Color(0xff7f92a7),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10)),
                     child:Text("confirm",style: TextStyle(fontSize: 12),),
                     onPressed:() {
                       print("ok");
                       widget.cus.lat=this.snapshot!.data!.locDat!.latitude;
                       widget.cus.lang=this.snapshot!.data!.locDat!.longitude;
                       widget.ser.eventProfileController.sink.add(new EdetCustomer(customer:widget.cus ));
                       Navigator.pop(context);
                     }
                 ),
                 RaisedButton(
                     color: Color(0xff7f92a7),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10)),
                     child:Text("Edit",style: TextStyle(fontSize: 12),),
                     onPressed:() {
                       Navigator.pop(context);
                       print("Edit");
                       methodMap();


                     }
                 )
               ],))


           ],)

      ),

       clipBehavior: Clip.antiAlias,
     );
     showDialog(
         context: context, builder: (BuildContext context) => simpleDialog);

  }

  Completer<GoogleMapController> _controller= Completer();
  static LatLng? _center ;
  LatLng? _lastMapPosition ;

  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _lastMapPosition = position.target;

      print("markerId^^^Nivo22222" + _lastMapPosition.toString());
    });
  }

  void _onAddMarkerButtonPressed() {

    print("ok remove");

    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(_lastMapPosition.toString()),

          position: _lastMapPosition,

          infoWindow: InfoWindow(

            // snippet: val.toString(),
          ),
          //  icon: await getMarkerIcon(img, Size(150.0, 150.0))
        ),
      );
    });
  }
  methodMap()
  {
    print("gado"+this.snapshot!.data!.locDat.toString());

    LatLng temp = LatLng(this.snapshot!.data.customer.lat,snapshot!.data.customer.lang);
    _center = LatLng(this.snapshot!.data.customer.lat,snapshot!.data.customer.lang);
    print("gado222"+_center.toString());
    _markers.add(
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _center,
          infoWindow: InfoWindow(
            //  title: title,
            // snippet: val.toString(),
          ),
        //   icon: pinLocationIcon),
          //await getMarkerIcon(img, Size(150.0, 150.0)))
        ));

        Dialog simpleDialog = Dialog(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    ),



      child: StatefulBuilder(
          builder: (context, setState) {
      return  Container(
        height: heightscreen/1.3,
        width: widthscreen,
        child: Stack(
          children: [
            GoogleMap(
              mapType: _currentMapType,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            compassEnabled: true,
              markers:_markers,
              onCameraMove:_onCameraMove,
            ),
            Container(
              height: heightscreen/16,
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: (){
                    setState((){_onMapTypeButtonPressed();});
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: Color(0xff7f92a7),
                  child: const Icon(Icons.map, size: 20.0),
                )),),

            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _onAddMarkerButtonPressed();

                    print("markerId^^^Nivo" + _lastMapPosition.toString());

                    widget.cus.lat = _lastMapPosition!.latitude;
                    widget.cus.lang = _lastMapPosition!.longitude;



                  });
                },
                //   materialTapTargetSize: MaterialTapTargetSize.padded,
                //  backgroundColor: Colors.green,
                icon: const Icon(
                  Icons.location_on_sharp,
                  size: 44.0,
                  color: Color(0xff7f92a7),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: ()
                {
                  setState((){
                    widget.ser.eventProfileController.sink.add(new EdetCustomer(customer:widget.cus ));

                  });
                  Navigator.pop(context);
                },

                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
                color: Color(0xff7f92a7),
                minWidth: widthscreen / 4.5,
                height: heightscreen / 17,
              ),
            ),
          ],
        ),
      );}
    ),
          clipBehavior: Clip.antiAlias,
        );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);

  }


  Widget getWidget(bool showOtherGender, bool alignVertical) {
    return Container(
     // margin: EdgeInsets.symmetric(vertical: 40),
     // alignment: Alignment.center,
      child: GenderPickerWithImage(
        showOtherGender: showOtherGender,
        verticalAlignedText: alignVertical,

        // to show what's selected on app opens, but by default it's Male
        selectedGender: Gender.Male,
        selectedGenderTextStyle: TextStyle(
            color: Color(0xff7f92a7), fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal),
        onChanged: (Gender? gender) {
          print(gender);
          if(gender!.index==0)
            {
              print("ok Gender");

            }
          widget.cus.gender=gender.index;
          widget.ser.eventProfileController.sink.add(new EdetCustomer(customer:widget.cus ));

          Navigator.pop(context);
        },
        //Alignment between icons
        equallyAligned: true,

        animationDuration: Duration(milliseconds: 600),
        isCircular: true,
        // default : true,
        opacityOfGradient: 0.4,
      padding: EdgeInsets.all(widthscreen/44),
        size: widthscreen/8, //default : 40
      ),
    );
  }

  methodStoreReq()
  {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StoreRequest()));
  }

}





