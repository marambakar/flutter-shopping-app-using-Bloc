

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yamams_market/homePage/category_model.dart';
import 'dart:io';

import 'package:yamams_market/service/block_sevice.dart';
import 'package:yamams_market/service/model/product.dart';
import 'package:yamams_market/sitting/sitting_screen.dart';
import 'package:easy_localization/src/public_ext.dart';


class AddService extends StatefulWidget {
  Product? sservic;
  AddService({this.sservic});
static  List<Category_model> tempList=[];
  @override
  AddServiceScreenBody createState() => AddServiceScreenBody();
  ServiceBloc ser = new ServiceBloc();
}

class AddServiceScreenBody extends State<AddService> {

  @override
  initState() {
    super.initState();
    widget.ser.eventController.sink
        .add(new adddropValuFitchcats(cats: []));

    if (widget.sservic != null) {
      print("the product id is "+widget.sservic!.prid.toString());
      if (widget.sservic!.caid != 0) {
       // dropdownvalue = widget.sservic!.type;
        chosenVal= widget.sservic!.caid;
      }
      if (widget.sservic!.photo != "") {
        imageFile = widget.sservic!.photo;
      }
      Namee.text=widget.sservic!.nameAr;
      NameeEn.text=widget.sservic!.nameEn;
      descript.text=widget.sservic!.descriptionAr;
      descriptEn.text=widget.sservic!.descriptionEn;
      pric.text=widget.sservic!.price.toString();

    }
  }

  double widthscreen = 0, heightscreen = 0;
  bool findText = false;
  bool fintselect = false;
  int Pricebool = 0;
  int DopValubool = 0;
  int ImagPathbool = 0;
  String? dropdounvalu;

  int? chosenVal;
  int tempvalue=0;
  TextEditingController Namee = new TextEditingController();
  TextEditingController NameeEn = new TextEditingController();
  TextEditingController descript = new TextEditingController();
  TextEditingController descriptEn = new TextEditingController();
  TextEditingController pric = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(),
            actions: [],
            centerTitle: true,
            title: Text(
              "Add new service".tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            )),
        body: StreamBuilder(
            stream: widget.ser.stateserviceController.stream,
            //output stream (Counetr)
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: widthscreen / 22,
                          right: widthscreen / 22,
                          top: heightscreen / 22),
                      child: Text(
                        "Name Service Arabic".tr(),
                        style: TextStyle(
                          color: Color(0xff3c4051),
                          fontSize: 12,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                        width: widthscreen / 1.2,
                      height: heightscreen / 15,
                        margin: EdgeInsets.only(
                            left: widthscreen / 22, right: widthscreen / 22),
                        padding:
                            EdgeInsets.only(left: widthscreen / 22,right:widthscreen / 22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(3, 4),
                            ),
                          ],
                          color: Color(0xffe5e5e5),
                        ),


                          child:
                          TextFormField(
                                //textAlign: TextAlign.start,
                               // textAlignVertical: TextAlignVertical.center,
                                controller: Namee,
                                onChanged: (value) {
                                  widget.ser.eventController.sink
                                      .add(new addServiceName(text: value));
                                },
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(

                                    hintText: widget.sservic != null
                                        ? widget.sservic!.nameAr == ""
                                            ? null
                                            : widget.sservic!.nameAr
                                        : null,

                                    border: InputBorder.none,
                                      hintStyle: TextStyle(fontSize: heightscreen/8),
                                    errorText: snapshot.data != null
                                        ? snapshot.data.errorNameService
                                        : null)),
                          ),

                    Container(
                      margin: EdgeInsets.only(
                          left: widthscreen / 22,
                          right: widthscreen / 22,
                          top: heightscreen / 22),
                      child: Text(
                        "Name Service English".tr(),
                        style: TextStyle(
                          color: Color(0xff3c4051),
                          fontSize: 12,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                        width: widthscreen / 1.2,
                        height: heightscreen / 15,
                        margin: EdgeInsets.only(
                            left: widthscreen / 22, right: widthscreen / 22),
                        padding:
                        EdgeInsets.symmetric(horizontal: widthscreen / 22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(3, 4),
                            ),
                          ],
                          color: Color(0xffe5e5e5),
                        ),
                        child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: NameeEn,
                            onChanged: (value) {
                              widget.ser.eventController.sink
                                  .add(new addServiceNameEn(text: value));
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: widget.sservic != null
                                    ? widget.sservic!.nameEn == ""
                                    ? ""
                                    : widget.sservic!.nameEn
                                    : null,
                                hintStyle: TextStyle(fontSize: heightscreen/8),
                                border: InputBorder.none,
                                errorText: snapshot.data != null
                                    ? snapshot.data.errorNameServiceEn
                                    : null))),
                    Container(
                      margin: EdgeInsets.only(
                          left: widthscreen / 22,
                          right: widthscreen / 22,
                          top: heightscreen / 22),
                      child: Text(
                        "Detail Service Arabic".tr(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff3c4051),
                          fontSize: 12,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: widthscreen / 1.2,
                      height: heightscreen / 3,
                      margin:
                          EdgeInsets.symmetric(horizontal: widthscreen / 22),
                      padding:
                          EdgeInsets.symmetric(horizontal: widthscreen / 22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f000000),
                            blurRadius: 4,
                            offset: Offset(3, 4),
                          ),
                        ],
                        color: Color(0xffe5e5e5),
                      ),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: TextFormField(
                              textAlign: TextAlign.start,
                              controller: descript,
                              onChanged: (value) {
                                widget.ser.eventController.sink.add(
                                    new addServicedescription(text: value));
                              },
                              keyboardType: TextInputType.name,

                              minLines: 1,
                              maxLines: 14,
                              decoration: InputDecoration(
                                  hintText: widget.sservic != null
                                      ? widget.sservic!.descriptionAr == ""
                                          ? ""
                                          : widget.sservic!.descriptionAr
                                      : "",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: heightscreen/44),
                                  errorText: snapshot.data != null
                                      ? snapshot.data.errorDescription
                                      : null))),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                          left: widthscreen / 22,
                          right: widthscreen / 22,
                          top: heightscreen / 22),
                      child: Text(
                        "Detail Service English".tr(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff3c4051),
                          fontSize: 12,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: widthscreen / 1.2,
                      height: heightscreen / 3,
                      margin:
                      EdgeInsets.symmetric(horizontal: widthscreen / 22),
                      padding:
                      EdgeInsets.symmetric(horizontal: widthscreen / 22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f000000),
                            blurRadius: 4,
                            offset: Offset(3, 4),
                          ),
                        ],
                        color: Color(0xffe5e5e5),
                      ),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: TextFormField(
                              textAlign: TextAlign.start,
                              controller: descriptEn,
                              onChanged: (value) {
                                widget.ser.eventController.sink.add(
                                    new addServicedescriptionEn(text: value));
                              },
                              keyboardType: TextInputType.name,
                              minLines: 1,
                              maxLines: 14,
                              decoration: InputDecoration(
                                  hintText: widget.sservic != null
                                      ? widget.sservic!.descriptionEn == ""
                                      ? ""
                                      : widget.sservic!.descriptionEn
                                      : "",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: heightscreen/44),
                                  errorText: snapshot.data != null
                                      ? snapshot.data.errorDescriptionEn
                                      : null))),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: widthscreen / 22,
                          right: widthscreen / 22,
                          top: heightscreen / 22),
                      child: Text(
                        "Type Service".tr(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff3c4051),
                          fontSize: 12,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: widthscreen / 1.2,
                      height: heightscreen / 16,
                      margin:
                          EdgeInsets.symmetric(horizontal: widthscreen / 22),
                      padding:
                          EdgeInsets.symmetric(horizontal: widthscreen / 22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f000000),
                            blurRadius: 4,
                            offset: Offset(3, 4),
                          ),
                        ],
                        color: Color(0xff7f92a7),
                      ),
                      // child: DropdownButton<int>(
                      //   value: dropdownvalue,
                      //   icon: Icon(
                      //     Icons.arrow_drop_down,
                      //     color: Colors.white,
                      //   ),
                      //   iconSize: 25,
                      //   elevation: 16,
                      //   style: TextStyle(color: Colors.white, fontSize: 18),
                      //   hint: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: widthscreen / 44),
                      //     child: Text(
                      //       "Please Enter the Type of Service",
                      //       style: TextStyle(fontSize: 14, color: Colors.white),
                      //     ),
                      //   ),
                      //   onChanged: (Category_model? newValue) {
                      //     print("new Valu"+newValue!.nameEn);
                      //     widget.ser.eventController.sink
                      //         .add(new adddropValu(text: newValue.nameEn));
                      //     DopValubool = 2;
                      //     setState(() {
                      //       dropdownvalue = newValue;
                      //     });
                      //     print("dropdownvaluedropdownvalue"+dropdownvalue!.nameEn);
                      //
                      //   },
                      //   isExpanded: true,
                      //   items: snapshot.data!=null?snapshot.data.catgs.map<DropdownMenuItem<Category_model>>((Category_model val) {
                      //     // ignore: missing_required_param
                      //     return DropdownMenuItem<Category_model>(
                      //       value: val.caid,
                      //       child: Text(
                      //         val.nameEn,
                      //         style: TextStyle(color: Colors.black),
                      //       ),
                      //     );
                      //   }).toList():null,
                      // ),
                      child:  DropdownButton<int>(
                                value: chosenVal,
                                //elevation: 5,
                                style: TextStyle(color: Colors.black),
                                items:AddService.tempList.map<DropdownMenuItem<int>>((item) {
                                  return DropdownMenuItem<int>(
                                    value: item.caid,
                                    child: Text(item.nameEn.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                           print("looooooooool");
                           widget.ser.eventController.sink
                               .add(new adddropValu(textt: value!));
                           DopValubool = 2;
                           chosenVal=value;
                           tempvalue=value;
                                },
                    hint:   Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widthscreen / 44),
                              child: Text(
                                "Please Enter the Type of Service".tr(),
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),

                            ),
                    ),
                    DopValubool == 1
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widthscreen / 33,
                                vertical: heightscreen / 88),
                            child: Text(
                              snapshot.data != null
                                  ? snapshot.data.errordropValu
                                  : null,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.only(
                          left: widthscreen / 22,
                          right: widthscreen / 22,
                          top: heightscreen / 22),
                      child: Text(
                        "Price".tr(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff3c4051),
                          fontSize: 12,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: widthscreen / 3.5,
                        ),
                        Container(
                          width: widthscreen / 4,
                          height: heightscreen / 14,
                          margin: EdgeInsets.symmetric(
                              horizontal: widthscreen / 22),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f000000),
                                blurRadius: 4,
                                offset: Offset(3, 4),
                              ),
                            ],
                            color: Color(0xffe5e5e5),
                          ),
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: pric,
                              onChanged: (value) {
                                widget.ser.eventController.sink
                                    .add(new addPrice(pr: double.parse(value)));
                                Pricebool = 2;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: widget.sservic != null
                                    ? widget.sservic!.price == 0
                                        ? "..."
                                        : widget.sservic!.price.toString()
                                    : "",
                              )),
                        ),
                        Text(
                          "S.R".tr(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff7f92a7),
                            fontSize: 20,
                            fontFamily: "DIN Next LT W23",
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    Pricebool == 1
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widthscreen / 44,
                                vertical: heightscreen / 88),
                            child: Text(
                              snapshot.data != null
                                  ? snapshot.data.errorPrice
                                  : null,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.only(
                          left: widthscreen / 22,
                          right: widthscreen / 22,
                          top: heightscreen / 22),
                      child: Text(
                        "Add Photo to Service".tr(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff3c4051),
                          fontSize: 12,
                          fontFamily: "DIN Next LT W23",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                          width: widthscreen / 1.2,
                          height: heightscreen / 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f000000),
                                blurRadius: 4,
                                offset: Offset(3, 4),
                              ),
                            ],
                            color: Color(0xffe5e5e5),
                          ),
                          child: Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                _showPicker(context);
                              },
                              child: Row(
                                children: [
                                  Image.asset("images/gallory.png"),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: widthscreen / 22),
                                      child: Text(
                                        imageFile==null?
                                        snapshot.data != null
                                            ? snapshot.data.imgpath
                                                .split('/')
                                                .last
                                            : "....": imageFile .split('/')
                                            .last,
                                        style: TextStyle(
                                          color: Color(0xff7f92a7),
                                          fontSize: 12,
                                          fontFamily: "DIN Next LT W23",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Image.asset("images/camera.png"),
                                ],
                              ),
                            ),
                          )),
                    ),
                    ImagPathbool == 1
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widthscreen / 44,
                                vertical: heightscreen / 88),
                            child: Text(
                              snapshot.data != null
                                  ? snapshot.data.errorImgPath
                                  : null,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: "DIN Next LT W23",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: heightscreen / 44,
                    ),
                    Center(
                        child: Container(
                          child: RaisedButton(
                      child: Text(
                          "Add".tr(),
                          //textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: "DIN Next LT W23",
                            fontWeight: FontWeight.w700,
                          ),
                      ),
                      shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      color: Color(0xff3c4051),
                      onPressed: () {
                          print(chosenVal.toString()+">>>>>>>>>>>>>>");
                          Product service = new Product();
                          service = new Product(
                              nameAr: Namee.text,
                              nameEn: NameeEn.text,
                              descriptionAr: descript.text,
                              descriptionEn: descriptEn.text,
                              price:
                              pric.text == "" ? 0 : double.parse(pric.text),
                              caid: tempvalue == 0 ? 0 : tempvalue,
                              photo: imageFile);
                          if(widget.sservic == null) {




                            widget.ser.eventController.sink
                                .add(new addOneService(ser: service,context:this.context));

                          }
                          else{
                            print("Name"+Namee.text);
                            service.photo=widget.sservic!.photo==null?imageFile:widget.sservic!.photo;
                            service.prid=widget.sservic!.prid;
                            service.caid=widget.sservic!.caid==0?tempvalue == 0 ? 0 : tempvalue:widget.sservic!.caid;
                            widget.ser.eventController.sink
                                .add(new EdetService(ser:service,context: this.context ));

                          }
                          print("heeeeeeeeer" + Namee.text.toString());
                          if (snapshot.data != null) {
                            if (snapshot.data.price == 0) {
                              Pricebool = 1;
                            }
                            if (snapshot.data.dropValue == 0) {
                              DopValubool = 1;
                            }
                            if (snapshot.data.imgpath=="") {
                              ImagPathbool = 1;
                            }

                          }

                      },
                    ),
                        )),
                    Container(
                      height: heightscreen / 22,
                    )
                  ],
                ),
              );
            }));
  }

  String imageFile = "";
  final ImagePicker _picker = ImagePicker();
  _imgFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    widget.ser.eventController.sink.add(new addImgPath(text: image!.path));
    imageFile = image.path;
    ImagPathbool = 2;
  }

  _imgFromGallery() async {
    final Future<XFile?> image = _picker.pickImage(source: ImageSource.gallery);
    image.then((value) => {
          widget.ser.eventController.sink
              .add(new addImgPath(text: value!.path)),
          imageFile = value.path,
        });
    ImagPathbool = 2;
  }

  void _showPicker(context) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        child: new Wrap(
          children: <Widget>[
            new ListTile(
                leading: Image.asset("images/gallory.png"),
                title: new Text('Photo Library'),
                onTap: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                }),
            new ListTile(
              leading: Image.asset("images/camera.png"),
              title: new Text('Camera'),
              onTap: () {
                _imgFromCamera();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      insetPadding: EdgeInsets.symmetric(
          vertical: heightscreen / 8, horizontal: widthscreen / 8),
      clipBehavior: Clip.antiAlias,
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }
}
