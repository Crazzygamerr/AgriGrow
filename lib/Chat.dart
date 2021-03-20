import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:agrigrow/Shared_pref.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {

    final DocumentReference ref;

    @override
    _ChatState createState() => _ChatState(ref);

    Chat(this.ref);
}

class _ChatState extends State<Chat> {
    _ChatState(this.ref);

    DocumentReference ref;
    bool isExpert;
    String email;
    TextEditingController textCon = new TextEditingController();
    Stream messages;

    @override
    void initState() {
        getMessages();
        super.initState();
    }

    getMessages() async {
        email = await SharedPref.getEmail();
        isExpert = await SharedPref.getDoc();
        ref.get().then((snapshot) {
            if(!snapshot.exists) {
                FirebaseFirestore.instance.collection("Farmers")
                        .doc(email).collection("Chats").doc(ref.path.split("/")[1])
                        .set({
                    "unread": false,
                });
                FirebaseFirestore.instance.doc(ref.path).set({}).then((value) {
                    setState(() {
                        messages = ref.collection("messages").orderBy("time", descending: true).snapshots();
                    });
                });
            } else {
                if(isExpert){
                    ref.update({"unread": false});
                } else {
                    FirebaseFirestore.instance.collection("Farmers")
                            .doc(email).collection("Chats").doc(ref.path.split("/")[1])
                            .set({
                        "unread": false,
                    });
                }
                setState(() {
                    messages = ref.collection("messages").orderBy("time", descending: true).snapshots();
                });
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.green,
                leading: GestureDetector(
                    onTap: () {
                        if(isExpert){
                            ref.update({"unread": false});
                        } else {
                            FirebaseFirestore.instance.collection("Farmers")
                                    .doc(email).collection("Chats").doc(ref.path.split("/")[1])
                                    .set({
                                "unread": false,
                            });
                        }
                        Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_outlined),
                ),
            ),
            body: SafeArea(
                child: Container(
                    padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(10),
                            ScreenUtil().setHeight(10),
                            ScreenUtil().setWidth(10),
                            ScreenUtil().setHeight(10)
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                            Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: messages,
                                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                                            return GestureDetector(
                                                onTap: () {

                                                },
                                                child: Center(
                                                    child: Container(
                                                        width: ScreenUtil().setWidth(20),
                                                        height: ScreenUtil().setWidth(20),
                                                        child: CircularProgressIndicator(),
                                                    ),
                                                ),
                                            );
                                        } else {
                                            return Container(
                                                padding: EdgeInsets.fromLTRB(
                                                        ScreenUtil().setWidth(10),
                                                        ScreenUtil().setHeight(10),
                                                        ScreenUtil().setWidth(10),
                                                        ScreenUtil().setHeight(10)
                                                ),
                                                child: ListView.builder(
                                                    itemCount: snapshot.data.docs.length,
                                                    padding: EdgeInsets.all(0),
                                                    physics: BouncingScrollPhysics(),
                                                    reverse: true,
                                                    scrollDirection: Axis.vertical,
                                                    itemBuilder: (context, pos) {

                                                        var d = DateTime.fromMillisecondsSinceEpoch(snapshot.data.docs[pos].data()['time'].seconds * 1000);
                                                        var date = DateFormat.yMd().add_jm().format(d);

                                                        return Container(
                                                            padding: EdgeInsets.fromLTRB(
                                                                    ScreenUtil().setWidth(0),
                                                                    ScreenUtil().setHeight(10),
                                                                    ScreenUtil().setWidth(0),
                                                                    ScreenUtil().setHeight(10)
                                                            ),
                                                            child: Row(
                                                                children: [
                                                                    (!(snapshot.data.docs[pos].data()["sender"] == "expert"))
                                                                            ?SizedBox(
                                                                        width: ScreenUtil().setWidth(30),
                                                                    ):Container(),

                                                                    Expanded(
                                                                        child: Column(
                                                                            crossAxisAlignment: (snapshot.data.docs[pos].data()["sender"] == "expert")
                                                                                    ?CrossAxisAlignment.start
                                                                                    :CrossAxisAlignment.end,
                                                                            children: [
                                                                                Text(
                                                                                    "$date",
                                                                                    style: TextStyle(
                                                                                            fontSize: ScreenUtil().setSp(8)
                                                                                    ),
                                                                                ),
                                                                                Text(snapshot.data.docs[pos].data()["content"]),
                                                                            ],
                                                                        ),
                                                                    ),

                                                                    (snapshot.data.docs[pos].data()["sender"] == "expert")
                                                                            ?SizedBox(
                                                                        width: ScreenUtil().setWidth(30),
                                                                    ):Container(),
                                                                ],
                                                            ),
                                                        );
                                                    },
                                                ),
                                            );
                                        }
                                    },
                                ),
                            ),
                            TextFormField(
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 6,
                                controller: textCon,
                                //focusNode: FutureProvider.of(context).focusNode,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black
                                                .withOpacity(0.2)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black
                                                .withOpacity(0.2)),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                            top: 2.0,
                                            left: 13.0,
                                            right: 13.0,
                                            bottom: 2.0),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                            Icons.send,
                                            color: Colors.black,
                                            size: 23,),
                                        onPressed: () {
                                            if(textCon.text != "" || textCon.text != null){
                                                ref.collection("messages")
                                                        .add({"time": DateTime.now(), "sender": (isExpert)?"expert":"user", "content": textCon.text});
                                                if(!isExpert){
                                                    ref.update({"unread": true});
                                                } else {
                                                    FirebaseFirestore.instance.collection("Farmers")
                                                            .doc(ref.path.split("/")[3]).collection("Chats").doc(email)
                                                            .set({
                                                        "unread": true,
                                                    });
                                                }
                                                textCon.clear();
                                            }
                                        },
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}