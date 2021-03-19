import 'package:agrigrow/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:agrigrow/HomeScreen.dart';
import 'package:agrigrow/Shared_pref.dart';
import 'package:agrigrow/screens/Login.dart';

class Register extends StatefulWidget {
    @override
    _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

    TextEditingController emailCon = new TextEditingController();
    TextEditingController passCon = new TextEditingController();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.green,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(160),
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(10)
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                CircleAvatar(
                                    radius: 85.0,
                                    backgroundImage: AssetImage('images/agrigrow.jpg'),
                                ),
                                Text(
                                    'AgriGrow',
                                    style: TextStyle(
                                        fontFamily: 'Tangerine',
                                        fontSize: ScreenUtil().setSp(40),
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500,
                                    ),
                                ),
                                Text(
                                    'Farming and More...',
                                    style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Colors.teal.shade100,
                                        fontSize: ScreenUtil().setSp(20),
                                        letterSpacing: 2.5,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                SizedBox(
                                    height: 20.0,
                                    width: 150.0,
                                    child: Divider(
                                        color: Colors.teal.shade100,
                                    ),
                                ),

                                TextFormField(
                                    controller: emailCon,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        labelText: 'Enter your email id',
                                        labelStyle: TextStyle(
                                            fontFamily: 'KaushanScript',
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                        ),
                                        border: new OutlineInputBorder(
                                            borderRadius: new BorderRadius.circular(25.0),
                                            borderSide: new BorderSide(
                                            ),

                                        ),

                                        fillColor: Colors.white,
                                    ),
                                ),
                                TextFormField(
                                    controller: passCon,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        labelText: 'Enter the Password',
                                        labelStyle: TextStyle(
                                            fontFamily: 'KaushanScript',
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                        ),
                                        border: new OutlineInputBorder(
                                            borderRadius: new BorderRadius.circular(25.0),
                                            borderSide: new BorderSide(
                                            ),

                                        ),

                                        fillColor: Colors.white,
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                ElevatedButton(
                                    onPressed: () {
                                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                                            email: emailCon.text.toString(),
                                            password: passCon.text.toString(),
                                        ).then((UserCredential user) {
                                            SharedPref.setUser(user.user.email, true, false);
                                            FirebaseFirestore.instance
                                                    .collection("Farmers")
                                                    .doc(emailCon.text)
                                                    .set({
                                                "Created on:": DateTime.now(),
                                            });
                                            Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                                        }).catchError((e){
                                            Fluttertoast.showToast(msg: e.message);
                                        });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white, // background
                                        onPrimary: Colors.green, // foreground
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10),
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10)
                                        ),
                                        child: Text(
                                            'Register as Farmer',
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(20),
                                            ),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                ElevatedButton(
                                    onPressed: () {
                                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                                            email: emailCon.text.toString(),
                                            password: passCon.text.toString(),
                                        ).then((UserCredential user) {
                                            SharedPref.setUser(user.user.email, true, true);
                                            //Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => (),), (route) => false);
                                        }).catchError((e){
                                            Fluttertoast.showToast(msg: e.message);
                                        });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white, // background
                                        onPrimary: Colors.green, // foreground
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10),
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10)
                                        ),
                                        child: Text(
                                            'Register as Agriculture Expert',
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(20),
                                            ),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                TextButton(
                                    onPressed: () {
                                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => Login(),), (route) => false);
                                    },
                                    child: Text(
                                        "Existing user? Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                ),

                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}
