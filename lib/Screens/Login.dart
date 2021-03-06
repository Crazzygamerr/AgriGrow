import 'package:agrigrow/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:agrigrow/HomeScreen.dart';
import 'package:agrigrow/Shared_pref.dart';
import 'package:agrigrow/Screens/Register.dart';

class Login extends StatefulWidget {
    @override
    _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

    TextEditingController emailCon = new TextEditingController();
    TextEditingController passCon = new TextEditingController();
    FocusNode node = new FocusNode();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.green,
            body: SafeArea(
                child: SingleChildScrollView(
           /* child: Container(
            constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('images/bg1.jpg'),
        ),*/
                    child: Container(


                        padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(180),
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
                                    height: ScreenUtil().setHeight(20),
                                    width: ScreenUtil().setWidth(150),
                                    child: Divider(
                                        color: Colors.teal.shade100,
                                    ),
                                ),
                                SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                ),

                                TextFormField(
                                    controller: emailCon,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    cursorColor: Colors.white,
                                    onEditingComplete: (){
                                        node.requestFocus();
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Email Address',
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
                                    height: ScreenUtil().setHeight(20),
                                ),
                                TextFormField(
                                    controller: passCon,
                                    focusNode: node,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    cursorColor: Colors.white,
                                    onEditingComplete: () {
                                        loginFunc();
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Enter your Password',
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'KaushanScript',
                                            fontStyle: FontStyle.italic,
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
                                        loginFunc();
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
                                            'Login',
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(20),
                                            ),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                ),

                                TextButton(
                                    onPressed: () {
                                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => Register(),), (route) => false);
                                    },
                                    child: Text(
                                        "New user? Register",
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

    void loginFunc() async {
        FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailCon.text.toString(),
            password: passCon.text.toString(),
        ).then((UserCredential user) {
            FirebaseFirestore.instance.collection("Experts").doc(emailCon.text).get().then((snapshot) {
                if(snapshot.exists){
                    SharedPref.setUser(user.user.email, true, true).then((value) {
                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                    });
                } else {
                    SharedPref.setUser(user.user.email, true, false).then((value) {
                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                    });
                }
            });
        }).catchError((e){
            Fluttertoast.showToast(msg: e.message);
        });
    }
}
