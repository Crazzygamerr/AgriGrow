import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CropScreen extends StatefulWidget {
    final Map<String, dynamic> map;

    @override
    _CropScreenState createState() => _CropScreenState(map);

    CropScreen(this.map);
}

class _CropScreenState extends State<CropScreen> {
    final Map<String, dynamic> map;

    _CropScreenState(this.map);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            //backgroundColor: Colors.green.shade400,
            appBar: AppBar(
                backgroundColor: Colors.green,
                title: Text(
                    map["Name"].toString(),
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                    ),
                ),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            SizedBox(
                                height: ScreenUtil().setHeight(30),
                            ),
                            ClipRect(
                                child: Container(
                                    child: Align(
                                        alignment: Alignment.center,
                                        widthFactor: 15,
                                        heightFactor: 1,
                                        child: Image.asset(
                                            "images/${map["Name"].toString().toLowerCase()}.jpg",
                                        ),
                                    ),
                                ),
                            ),


                            Text(

                                map["Name"],
                                style: TextStyle(
                                    fontFamily: 'Tangerine',
                                    fontSize: ScreenUtil().setSp(50),
                                    //color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                ),
                            ),
                            Text(
                                "Soil Type: " + map["Soil"],
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    //color: Colors.teal.shade100,
                                    fontSize: ScreenUtil().setSp(18),
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(
                                "Temperature: " + map["Temperature"],
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    //color: Colors.teal.shade100,
                                    fontSize: ScreenUtil().setSp(18),
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(
                                "Rainfall: " + map["Rainfall"],
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    //color: Colors.teal.shade100,
                                    fontSize: ScreenUtil().setSp(18),
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(
                                "Type of crop: " + map["Typeofcrop"],
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    //color: Colors.teal.shade100,
                                    fontSize: ScreenUtil().setSp(18),
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(0),
                                    ScreenUtil().setHeight(15),
                                    ScreenUtil().setWidth(0),
                                    ScreenUtil().setHeight(5),
                                ),
                                child: Text(
                                    "Description: ",
                                    style: TextStyle(
                                        fontFamily: 'Source Sans Pro',
                                        //color: Colors.teal.shade100,
                                        fontSize: ScreenUtil().setSp(18),
                                        letterSpacing: 2.5,
                                        fontWeight: FontWeight.bold,
                                       // fontStyle: FontStyle.italic,
                                    ),
                                ),
                            ),
                            Text(
                                map["Description"],
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    //color: Colors.teal.shade100,
                                    fontSize: ScreenUtil().setSp(12),
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                ),
                            ),

                        ],
                    ),
                ),
            ),
        );
    }
}
