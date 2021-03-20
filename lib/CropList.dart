import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

import 'cropscreen.dart';

class CropList extends StatefulWidget {
    @override
    _CropListState createState() => _CropListState();
}

class _CropListState extends State<CropList> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    "List of crops",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: Colors.white,
                    ),
                ),
                backgroundColor: Colors.green,
            ),
            body: SafeArea(
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context).loadString("data.json"),
                    builder: (context, snapshot) {
                        List<dynamic> mydata = json.decode(snapshot.data.toString());

                        if(mydata == null)
                            return Container();
                        else
                            return Container(
                            child: ListView.builder(
                                itemCount: mydata.length,
                                itemBuilder: (context, pos) {
                                    return GestureDetector(
                                        onTap: () {
                                            if(pos <= 4)
                                                Navigator.push(context, new MaterialPageRoute(builder: (context) => CropScreen(mydata[pos]),),);
                                        },
                                        child: Card(
                                            child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    ScreenUtil().setWidth(20),
                                                    ScreenUtil().setHeight(20),
                                                    ScreenUtil().setWidth(20),
                                                    ScreenUtil().setHeight(20),
                                                ),
                                                child: Text(
                                                    mydata[pos]["Name"].toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'Source Sans Pro',
                                                        color: Colors.green,

                                                    ),
                                                ),
                                            ),
                                        ),
                                    );
                                },
                            ),
                        );
                    },
                ),
            ),
        );
    }
}
