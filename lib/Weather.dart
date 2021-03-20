import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text(
                "Weather Report",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                ),
            ),
        ),
        body: Center(
            child: Text(
                "Coming soon!",
            ),
        ),
    );
  }
}
