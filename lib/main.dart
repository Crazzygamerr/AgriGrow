import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
/*import 'package:agrigrow/HomeScreen.dart';
import 'package:agrigrow/Shared_pref.dart';
import 'package:agrigrow/screens/Login.dart';*/

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 866.3),
      allowFontScaling: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Loading(),
      ),
    );
  }
}

/*
class _MyAppState extends State<MyApp> {
    */
/*bool log;
    @override
    void initState() {
        b().then((value){
            setState(() {
              value = log;
            });
        });
        super.initState();
    }*//*


    Future<bool> b() async {
        return await SharedPref.getUserLogin();
    }

    @override
    Widget build(BuildContext context) {
        return ScreenUtilInit(
            designSize: Size(411.4, 866.3),
            allowFontScaling: true,
            builder: () => MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomePage(),
            ),
        );
    }
}
*/

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    b().then((value){
      if(value){
        //Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);
      } else {
        //Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=> Login()), (route) => false);
      }
    });
    super.initState();
  }

  Future<bool> b() async {
    //return await SharedPref.getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}