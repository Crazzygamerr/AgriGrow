import 'package:agrigrow/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:agrigrow/HomeScreen.dart';
import 'package:agrigrow/Shared_pref.dart';

class ExpertInfo extends StatefulWidget {
    @override
    _ExpertInfoState createState() => _ExpertInfoState();
}

class _ExpertInfoState extends State<ExpertInfo> {

    TextEditingController textCon1 = new TextEditingController();
    TextEditingController textCon2 = new TextEditingController();
    TextEditingController textCon3 = new TextEditingController();
    TextEditingController textCon4 = new TextEditingController();

    FocusNode node = new FocusNode();

    String email;
    @override
    void initState() {
        b().then((value){
            setState(() {
                email = value;
            });
        });
        super.initState();
    }

    Future<String> b() async {
        return await SharedPref.getEmail();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            //backgroundColor: Colors.teal,
            appBar: AppBar(
                //backgroundColor: Colors.teal,
                elevation: 0,
                title: GestureDetector(
                    onTap: () {
                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                    },
                    child: Container(
                        padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(10),
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(10)
                        ),
                        //width: ScreenUtil().setWidth(100),
                        child: Text(
                            "Cancel",
                        ),
                    ),
                ),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),
                                CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: AssetImage('images/agrigrow.jpg'),
                                ),
                                Text(
                                    'agrigrow',
                                    style: TextStyle(
                                        fontFamily: 'Pacifico',
                                        fontSize: ScreenUtil().setSp(40),
                                        //color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                Text(
                                    '*insert desctiption here*',
                                    style: TextStyle(
                                        fontFamily: 'Source Sans Pro',
                                        //color: Colors.teal.shade100,
                                        fontSize: ScreenUtil().setSp(20),
                                        letterSpacing: 2.5,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                    width: ScreenUtil().setWidth(150),
                                    child: Divider(
                                        //color: Colors.teal.shade100,
                                    ),
                                ),
                                TextFormField(
                                    controller: textCon1,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        //color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    //cursorColor: Colors.white,
                                    onEditingComplete: () {
                                        node.requestFocus();
                                    },
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.person),
                                        hintText: 'Whats Your Name?',
                                        labelText: 'Name *',
                                        labelStyle: TextStyle(
                                            //color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                        ),
                                    ),
                                ),

                                TextFormField(
                                    controller: textCon2,
                                    focusNode: node,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: null,
                                    style: TextStyle(
                                        //color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    //cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.person),
                                        hintText: 'From where have you graduated ?',
                                        labelText: 'Qualifications *',
                                        labelStyle: TextStyle(
                                            //color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                        ),
                                    ),
                                ),
                                TextFormField(
                                    controller: textCon3,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: null,
                                    style: TextStyle(
                                        //color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    //cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.person),
                                        hintText: 'In which field are you specialized ?',
                                        labelText: 'Specialization *',
                                        labelStyle: TextStyle(
                                            //color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                        ),
                                    ),
                                ),
                                TextFormField(
                                    controller: textCon4,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: null,
                                    style: TextStyle(
                                        //color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    //cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.person),
                                        hintText: 'Any field that you excel in',
                                        labelText: 'Expertise *',
                                        labelStyle: TextStyle(
                                            //color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                ElevatedButton(
                                    onPressed: () {
                                        FirebaseFirestore.instance.collection("Experts").doc(email).set({
                                            "Name": textCon1.text,
                                            "Qualifications": textCon2.text,
                                            "Specialization": textCon3.text,
                                            "Expertise": textCon4.text,
                                        });
                                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10),
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10)
                                        ),
                                        child: Text(
                                            'Save and Exit',
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(20),
                                            ),
                                        ),
                                    ),
                                ),

                            ],
                        ),
                    ),
                ),
            ),

        ); // This trailing comma makes auto-formatting nicer for build methods.
    }
}