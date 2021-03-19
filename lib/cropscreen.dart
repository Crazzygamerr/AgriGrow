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
            backgroundColor: Colors.green.shade400,
            appBar: AppBar(
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
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 50.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(
                                map["Soil"],
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    //color: Colors.teal.shade100,
                                    fontSize: 28.0,
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(

                                map["Temperature"],
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    //color: Colors.teal.shade100,
                                    fontSize: 28.0,
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(

                                map["Rainfall"],
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    //color: Colors.teal.shade100,
                                    fontSize: 28.0,
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(

                                map["Typeofcrop"],
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    //color: Colors.teal.shade100,
                                    fontSize: 28.0,
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text(

                                map["Description"],
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    //color: Colors.teal.shade100,
                                    fontSize: 28.0,
                                    letterSpacing: 2.5,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),


                        ],
                    ),
                ),
            ),
        );
    }
}