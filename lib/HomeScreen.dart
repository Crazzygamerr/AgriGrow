import 'dart:async';
import 'dart:io';

import 'package:agrigrow/CropList.dart';
//import 'package:agrigrow/MSP.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agrigrow/ExpertInfo.dart';
import 'package:agrigrow/Shared_pref.dart';
import 'package:agrigrow/chat.dart';
import 'package:agrigrow/profile.dart';
import 'package:agrigrow/screens/Login.dart';

class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    bool chat = true;
    String email, query = "", category = "All";
    List<String> categories = ['All', 'Name', 'Qualifications', 'Specialization', 'Expertise'];
    bool isExpert = false, searching = false;
    Stream<QuerySnapshot> experts, chats;
    TextEditingController textCon = new TextEditingController();

    CollectionReference collectionReference;

    @override
    void initState() {
        getCred().then((value) {
            getList();
        });
        super.initState();
    }

    Future getCred() async {
        email = await SharedPref.getEmail();
        isExpert = await SharedPref.getDoc();
    }

    Future getList() async {

        if(isExpert){
            collectionReference = FirebaseFirestore.instance
                    .collection("Experts")
                    .doc(email)
                    .collection("Farmers");
        } else {
            collectionReference = FirebaseFirestore.instance
                    .collection("Farmers")
                    .doc(email)
                    .collection("Chats");

            experts = FirebaseFirestore.instance
                    .collection("Experts")
                    .snapshots();
        }
        chats = await collectionReference.snapshots();
        setState(() {
        });
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            //backgroundColor: Colors.teal,
            appBar: AppBar(
                //backgroundColor: Colors.teal,
                elevation: 0,
                title: (!searching)
                        ? Text(chat?"Chats":"Experts")
                        : TextFormField(
                    controller: textCon,
                    onChanged: (s) {
                        setState(() {
                            query = textCon.text;
                        });
                    },
                    style: TextStyle(
                        //color: Colors.white,
                        fontSize: ScreenUtil().setSp(15),
                    ),
                    //cursorColor: Colors.white,
                    onEditingComplete: (){
                        FocusScope.of(context).unfocus();
                    },
                ),
                /*actions: [
                        (!chat)?GestureDetector(
                            onTap: () {
                                if(searching) {
                                    setState(() {
                                        query = "";
                                        searching = false;
                                    });
                                } else {
                                    setState(() {
                                        searching = true;
                                    });
                                }
                            },
                            child: Container(
                                padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(10),
                                        ScreenUtil().setHeight(10),
                                        ScreenUtil().setWidth(20),
                                        ScreenUtil().setHeight(10)
                                ),
                                child: Icon((searching)?Icons.clear:Icons.search),
                            ),
                        ):Container(),

                        (searching)?DropdownButton<String>(
                            value: category,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String newValue) {
                                if(newValue != category){
                                    setState(() {
                                        category = newValue;
                                    });
                                }
                            },
                            items: List.generate(
                                    categories.length,
                                            (index){
                                        return DropdownMenuItem(
                                            value: categories.elementAt(index),
                                            child: Text(
                                                categories.elementAt(index),
                                                style: TextStyle(
                                                    fontSize: ScreenUtil().setSp(10),
                                                ),
                                            ),
                                        );
                                    }
                            ),
                        ):Container(),

                    ],*/
            ),
            drawer: Container(
                color: Colors.white,
                width: ScreenUtil().setWidth(300),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                        Column(
                            children: [
                                SizedBox(
                                    height: ScreenUtil().setHeight(50),
                                ),

                                /*Row(
                                    children: [
                                        SizedBox(
                                            width: ScreenUtil().setWidth(10),
                                        ),
                                        CircleAvatar(
                                            radius: 50.0,
                                            backgroundImage: AssetImage('images/agrigrow.jpg'),
                                        ),
                                        SizedBox(
                                            width: ScreenUtil().setWidth(10),
                                        ),
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                Text(
                                                    'agrigrow',
                                                    style: TextStyle(
                                                        fontFamily: 'Pacifico',
                                                        fontSize: ScreenUtil().setSp(20),
                                                        color: Colors.teal,
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                                Text(
                                                    'Virtual Health CheckUp',
                                                    style: TextStyle(
                                                        fontFamily: 'Source Sans Pro',
                                                        color: Colors.teal.shade300,
                                                        fontSize: ScreenUtil().setSp(10),
                                                        letterSpacing: 2.5,
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ],
                                ),

                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.fromLTRB(
                                            ScreenUtil().setWidth(20),
                                            ScreenUtil().setHeight(20),
                                            ScreenUtil().setWidth(20),
                                            ScreenUtil().setHeight(50)
                                    ),
                                    child: Text(
                                        (email==null)?"":email,
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(20),
                                        ),
                                    ),
                                ),
                                SizedBox(
                                    height: ScreenUtil().setHeight(0),
                                    width: double.infinity,
                                    child: Divider(
                                        color: Colors.teal.shade300,
                                    ),
                                ),*/

                                (isExpert)?Container(
                                    width: double.infinity,
                                    child: TextButton(
                                        onPressed: (){
                                            Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => ExpertInfo(),),(route) => false);
                                        },
                                        child: Text(
                                            "Change details",
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(13),
                                            ),
                                        ),
                                    ),
                                ):Container(),

                                SizedBox(
                                    height: ScreenUtil().setHeight((isExpert)?30:0),
                                ),

                                (!isExpert)?Container(
                                    width: double.infinity,
                                    //color: Colors.deepPurpleAccent,
                                    child: TextButton(
                                        onPressed: (){
                                            setState(() {
                                                chat = false;
                                                searching = false;
                                                query = "";
                                            });
                                            Navigator.pop(context);
                                        },
                                        child: Text(
                                            "Experts",
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(13),
                                                ////color: Colors.white,
                                            ),
                                        ),
                                    ),
                                ):Container(),

                                SizedBox(
                                    height: ScreenUtil().setHeight((!isExpert)?30:0),
                                ),

                                Container(
                                    width: double.infinity,
                                    child: TextButton(
                                        onPressed: (){
                                            setState(() {
                                                chat = true;
                                                searching = false;
                                                query = "";
                                            });
                                            Navigator.pop(context);
                                        },
                                        child: Text(
                                            "Chats",
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(13),
                                            ),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                Container(
                                    width: double.infinity,
                                    child: TextButton(
                                        onPressed: (){
                                            Navigator.push(context, new MaterialPageRoute(builder: (context) => CropList(),),);
                                        },
                                        child: Text(
                                            "View Crops",
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(13),
                                            ),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                Container(
                                    width: double.infinity,
                                    child: TextButton(
                                        onPressed: (){
                                            //Navigator.push(context, new MaterialPageRoute(builder: (context) => MSP(),),);
                                        },
                                        child: Text(
                                            "Check MSP",
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(13),
                                            ),
                                        ),
                                    ),
                                ),
                            ],
                        ),

                        /*SizedBox(
                            height: ScreenUtil().setHeight(350),
                        ),*/
                        Column(
                            children: [
                                SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                    width: double.infinity,
                                    child: Divider(
                                        //color: Colors.teal.shade300,
                                    ),
                                ),
                                Container(
                                    width: double.infinity,
                                    child: TextButton(
                                        onPressed: (){
                                            SharedPref.setUserLogin(false);
                                            Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => Login(),), (route) => false);
                                        },
                                        child: Text(
                                            "Log out",
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(13),
                                            ),
                                        ),
                                    ),
                                ),
                            ],
                        ),

                    ],
                ),
            ),
            body: Container(
                child: (chat)?StreamBuilder<QuerySnapshot>(
                        stream: chats,
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                            if (!snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                    child: Container(
                                        width: ScreenUtil().setWidth(20),
                                        height: ScreenUtil().setWidth(20),
                                        child: CircularProgressIndicator(),
                                    ),
                                );
                            } else if(snapshot.data.docs.length == 0) {
                                return Center(
                                    child: Container(
                                        child: Text(
                                            "No chats yet!",
                                        ),
                                    ),
                                );
                            } else {
                                return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, pos) {

                                        DocumentReference reference;
                                        FirebaseFirestore.instance
                                                .collection("Experts")
                                                .doc(snapshot.data.docs[pos].id)
                                                .collection("Farmers")
                                                .doc(email)
                                                .get().then((value) {
                                            reference = value.reference;
                                        });

                                        return GestureDetector(
                                            onTap: () {
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (context) => Chat((isExpert)
                                                                ?snapshot.data.docs[pos].reference
                                                                :reference
                                                        ),
                                                    ),
                                                );
                                            },
                                            child: Card(
                                                child: Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                            ScreenUtil().setWidth(20),
                                                            ScreenUtil().setHeight(20),
                                                            ScreenUtil().setWidth(20),
                                                            ScreenUtil().setHeight(20)
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                            Text(
                                                                snapshot.data.docs[pos].id,
                                                            ),
                                                            Opacity(
                                                                opacity: (snapshot.data.docs[pos].data()['unread'] == null)? 0 : (snapshot.data.docs[pos].data()['unread']) ? 1 : 0,
                                                                child: Icon(
                                                                    Icons.brightness_1,
                                                                    color: Colors.green,
                                                                ),
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                            ),
                                        );
                                    },
                                );
                            }
                        }
                ):StreamBuilder<QuerySnapshot>(
                        stream: experts,
                        builder: (context, snapshot) {

                            if (!snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                    child: Container(
                                        width: ScreenUtil().setWidth(20),
                                        height: ScreenUtil().setWidth(20),
                                        child: CircularProgressIndicator(),
                                    ),
                                );
                            } else {
                                return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, pos) {

                                        bool visible = !searching;
                                        if(searching){
                                            if(category == "All"){
                                                if(snapshot.data.docs[pos].id.toString().toLowerCase().contains(query.toLowerCase())) {
                                                    visible = true;
                                                }
                                                snapshot.data.docs[pos].data().forEach((key, value) {
                                                    if(value.toString().toLowerCase().contains(query.toLowerCase()))
                                                        visible = true;
                                                });
                                            } else {
                                                if(snapshot.data.docs[pos].data()[category].toString().toLowerCase().contains(query.toLowerCase()))
                                                    visible = true;
                                            }
                                        }

                                        return (!visible)?Container():GestureDetector(
                                            onTap: () {
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (context) => Profile(snapshot.data.docs[pos].reference, email),
                                                    ),
                                                );
                                                /*snapshot.data.docs[pos].reference.set({
                                          "About": "some description",
                                          "Name": "name",
                                          "Email": "email",
                                          "other fields": "",
                                      });*/
                                                /*snapshot.data.docs[pos].reference.collection("Farmers").doc("patient@gmail.com").set({
                                          "email": "Email",
                                          "Name": "name",
                                      });*/
                                            },
                                            child: Card(
                                                child: Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                            ScreenUtil().setWidth(20),
                                                            ScreenUtil().setHeight(20),
                                                            ScreenUtil().setWidth(20),
                                                            ScreenUtil().setHeight(20)
                                                    ),
                                                    child: Text(
                                                            snapshot.data.docs[pos].id
                                                    ),
                                                ),
                                            ),
                                        );
                                    },
                                );
                            }
                        }
                ),
            ),
        );
    }
}