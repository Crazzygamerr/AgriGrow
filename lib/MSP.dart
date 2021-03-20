import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MSP extends StatefulWidget {
    @override
    _MSPState createState() => _MSPState();
}

class _MSPState extends State<MSP> {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.green,
                title: Text(
                    "Minimum Support Price (MSP)",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                    ),
                ),
            ),
            body: SafeArea(
                child: Container(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(10),
                        ScreenUtil().setHeight(10),
                        ScreenUtil().setWidth(10),
                        ScreenUtil().setHeight(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text("Official Govt. website: ",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(12),
                                ),
                            ),
                            GestureDetector(
                                child: Text("https://farmer.gov.in/mspstatements.aspx",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(15),
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue
                                    ),
                                    textAlign: TextAlign.start,
                                ),
                                onTap: () async {
                                    await launch("https://farmer.gov.in/mspstatements.aspx");
                                },
                            ),

                            SizedBox(
                                height: ScreenUtil().setHeight(30),
                            ),

                            Text("Minimum Support Prices - Fixed by Government (Rs.quintal)",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(17),
                                ),
                            ),

                            SizedBox(
                                height: ScreenUtil().setHeight(30),
                            ),

                            FutureBuilder<http.Response>(
                                    future: http.Client().get(Uri.parse("https://farmer.gov.in/mspstatements.aspx")),
                                    builder: (context, AsyncSnapshot<http.Response> snapshot) {

                                        if(snapshot.data == null || snapshot.data.statusCode != 200)
                                            return Expanded(
                                                child: Center(
                                                    child: CircularProgressIndicator(),
                                                ),
                                            );
                                        else {
                                            var document = parse(snapshot.data.body);
                                            var rows = document.querySelectorAll("tr");
                                            for(int i=0;i<rows.length;i++){
                                                var ele = rows[i].querySelectorAll("td");
                                                ele[0].text = ele[0].text.replaceAll("(Calender Year)", "");
                                                ele[0].text = ele[0].text.replaceAll("Calender Year)", "");

                                                if(ele[0].outerHtml.toString().contains("rowspan")){
                                                    rows[i+1].children.insert(0, ele[0].clone(true));
                                                    ele[0].text = ele[0].text
                                                            + " - " + ele[1].text;
                                                    rows[i+1].querySelectorAll("td")[0].text = rows[i+1].querySelectorAll("td")[0].text
                                                            + " - " + rows[i+1].querySelectorAll("td")[1].text;
                                                    //print("tried" + ele[0].outerHtml.toString());
                                                    i++;
                                                } else if(ele[1].text.contains(RegExp(r'[a-zA-Z]'))
                                                & !ele[1].innerHtml.contains("-")) {
                                                    if(ele[0].text.trim() != "") {
                                                        ele[0].text = ele[0].text
                                                                + " - " + ele[1].text;
                                                    } else {
                                                        ele[0].text = rows[i-1].querySelectorAll("td")[0].text
                                                                .substring(0, rows[i-1].querySelectorAll("td")[0].text.indexOf(" "))
                                                                + " - " + ele[1].text;
                                                    }
                                                }
                                                //print(ele[0].outerHtml.toString() + "\n");
                                            }
                                            return Expanded(
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: Colors.black,
                                                        ),
                                                    ),
                                                    child: ListView.builder(
                                                        itemCount: rows.length,
                                                        itemBuilder: (context, pos) {
                                                            if(pos == 0 || pos == 1
                                                                    || pos > rows.length-8){
                                                                return Container();
                                                            } else if(rows[pos].querySelectorAll("td")[0].outerHtml.toString().contains("colspan")){
                                                                return Container(
                                                                    padding: EdgeInsets.fromLTRB(
                                                                        ScreenUtil().setWidth(10),
                                                                        ScreenUtil().setHeight(10),
                                                                        ScreenUtil().setWidth(10),
                                                                        ScreenUtil().setHeight(10),
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            width: 0.5,
                                                                            color: Colors.black,
                                                                        ),
                                                                    ),
                                                                    child: Text(rows[pos].querySelectorAll("td")[0].text.toString()),
                                                                );
                                                            } else {
                                                                return GestureDetector(
                                                                    onTap: () {
                                                                        if(double.tryParse(rows[pos].querySelectorAll("td")
                                                                        [rows[pos].querySelectorAll("td").length-1].text) != null){

                                                                            showBottomSheet(
                                                                                context: context,
                                                                                backgroundColor: Colors.transparent,
                                                                                builder: (context) {
                                                                                    double p = double.parse(rows[pos].querySelectorAll("td")
                                                                                    [rows[pos].querySelectorAll("td").length-1].text);
                                                                                    double q = 1;
                                                                                    return StatefulBuilder(
                                                                                            builder: (context, setSheet) {
                                                                                                return Container(
                                                                                                    color: Colors.transparent,
                                                                                                    child: Column(
                                                                                                        children: [
                                                                                                            Expanded(
                                                                                                                child: GestureDetector(
                                                                                                                    onTap: () {
                                                                                                                        Navigator.pop(context);
                                                                                                                    },
                                                                                                                    child: Container(
                                                                                                                        color: Colors.transparent,
                                                                                                                    ),
                                                                                                                ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                                height: ScreenUtil().setHeight(220),
                                                                                                                width: double.infinity,
                                                                                                                decoration: BoxDecoration(
                                                                                                                    color: Colors.white,
                                                                                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                                                                    boxShadow: [
                                                                                                                        BoxShadow(
                                                                                                                            blurRadius: 10,
                                                                                                                            color: Colors.grey[300],
                                                                                                                            spreadRadius: 5,
                                                                                                                        ),
                                                                                                                    ],
                                                                                                                ),
                                                                                                                padding: EdgeInsets.fromLTRB(
                                                                                                                    ScreenUtil().setWidth(10),
                                                                                                                    ScreenUtil().setHeight(10),
                                                                                                                    ScreenUtil().setWidth(10),
                                                                                                                    ScreenUtil().setHeight(10),
                                                                                                                ),
                                                                                                                child: Column(
                                                                                                                    children: [
                                                                                                                        Container(
                                                                                                                            padding: EdgeInsets.fromLTRB(
                                                                                                                                ScreenUtil().setWidth(10),
                                                                                                                                ScreenUtil().setHeight(10),
                                                                                                                                ScreenUtil().setWidth(10),
                                                                                                                                ScreenUtil().setHeight(25),
                                                                                                                            ),
                                                                                                                            alignment: Alignment.centerLeft,
                                                                                                                            child: Text("Calculate price for ${rows[pos].querySelectorAll("td")[0].text}",
                                                                                                                                style: TextStyle(
                                                                                                                                    fontSize: ScreenUtil().setSp(17),
                                                                                                                                ),
                                                                                                                            ),
                                                                                                                        ),
                                                                                                                        Row(
                                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                                            children: [
                                                                                                                                Container(
                                                                                                                                    padding: EdgeInsets.fromLTRB(
                                                                                                                                        ScreenUtil().setWidth(0),
                                                                                                                                        ScreenUtil().setHeight(10),
                                                                                                                                        ScreenUtil().setWidth(5),
                                                                                                                                        ScreenUtil().setHeight(15),
                                                                                                                                    ),
                                                                                                                                    child: Text("\u{20B9}",
                                                                                                                                        style: TextStyle(
                                                                                                                                            fontSize: ScreenUtil().setSp(15),
                                                                                                                                        ),
                                                                                                                                    ),
                                                                                                                                ),
                                                                                                                                Column(
                                                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                    children: [
                                                                                                                                        Text("   Price:",
                                                                                                                                            style: TextStyle(
                                                                                                                                                fontSize: ScreenUtil().setSp(15),
                                                                                                                                            ),
                                                                                                                                        ),
                                                                                                                                        Container(
                                                                                                                                            height: ScreenUtil().setHeight(50),
                                                                                                                                            width: ScreenUtil().setWidth(165),
                                                                                                                                            alignment: Alignment.center,
                                                                                                                                            padding: EdgeInsets.fromLTRB(
                                                                                                                                                ScreenUtil().setWidth(10),
                                                                                                                                                ScreenUtil().setHeight(10),
                                                                                                                                                ScreenUtil().setWidth(10),
                                                                                                                                                ScreenUtil().setHeight(10),
                                                                                                                                            ),
                                                                                                                                            decoration: BoxDecoration(
                                                                                                                                                color: Colors.grey[300],
                                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                                            ),
                                                                                                                                            child: TextFormField(
                                                                                                                                                keyboardType: TextInputType.number,
                                                                                                                                                initialValue: rows[pos].querySelectorAll("td")
                                                                                                                                                [rows[pos].querySelectorAll("td").length-1].text,
                                                                                                                                                onChanged: (s) {
                                                                                                                                                    setSheet(() {
                                                                                                                                                        if(s == "")
                                                                                                                                                            p = 0;
                                                                                                                                                        else
                                                                                                                                                            p = double.parse(s);
                                                                                                                                                    });
                                                                                                                                                },
                                                                                                                                                decoration: InputDecoration.collapsed(
                                                                                                                                                    hintText: 'Price',
                                                                                                                                                ),
                                                                                                                                            ),
                                                                                                                                        ),
                                                                                                                                    ],
                                                                                                                                ),

                                                                                                                                Container(
                                                                                                                                    padding: EdgeInsets.fromLTRB(
                                                                                                                                        ScreenUtil().setWidth(10),
                                                                                                                                        ScreenUtil().setHeight(0),
                                                                                                                                        ScreenUtil().setWidth(10),
                                                                                                                                        ScreenUtil().setHeight(15),
                                                                                                                                    ),
                                                                                                                                    child: Icon(
                                                                                                                                        Icons.clear,
                                                                                                                                    ),
                                                                                                                                ),

                                                                                                                                Column(
                                                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                    children: [
                                                                                                                                        Text("   Qty:",
                                                                                                                                            style: TextStyle(
                                                                                                                                                fontSize: ScreenUtil().setSp(15),
                                                                                                                                            ),
                                                                                                                                        ),
                                                                                                                                        Container(
                                                                                                                                            height: ScreenUtil().setHeight(50),
                                                                                                                                            width: ScreenUtil().setWidth(165),
                                                                                                                                            alignment: Alignment.center,
                                                                                                                                            padding: EdgeInsets.fromLTRB(
                                                                                                                                                ScreenUtil().setWidth(10),
                                                                                                                                                ScreenUtil().setHeight(10),
                                                                                                                                                ScreenUtil().setWidth(10),
                                                                                                                                                ScreenUtil().setHeight(10),
                                                                                                                                            ),
                                                                                                                                            decoration: BoxDecoration(
                                                                                                                                                color: Colors.grey[300],
                                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                                            ),
                                                                                                                                            child: TextFormField(
                                                                                                                                                keyboardType: TextInputType.number,
                                                                                                                                                initialValue: '1',
                                                                                                                                                onChanged: (s) {
                                                                                                                                                    setSheet(() {
                                                                                                                                                        if(s == "")
                                                                                                                                                            q = 0;
                                                                                                                                                        else
                                                                                                                                                            q = double.parse(s);
                                                                                                                                                    });
                                                                                                                                                },
                                                                                                                                                decoration: InputDecoration.collapsed(
                                                                                                                                                    hintText: 'Qty',
                                                                                                                                                ),
                                                                                                                                            ),
                                                                                                                                        ),
                                                                                                                                    ],
                                                                                                                                ),
                                                                                                                            ],
                                                                                                                        ),
                                                                                                                        Container(
                                                                                                                            //alignment: Alignment.centerLeft,
                                                                                                                            padding: EdgeInsets.fromLTRB(
                                                                                                                                ScreenUtil().setWidth(10),
                                                                                                                                ScreenUtil().setHeight(20),
                                                                                                                                ScreenUtil().setWidth(10),
                                                                                                                                ScreenUtil().setHeight(10),
                                                                                                                            ),
                                                                                                                            child: (p >= double.parse(rows[pos].querySelectorAll("td")
                                                                                                                            [rows[pos].querySelectorAll("td").length-1].text))
                                                                                                                                    ?Text("Total = \u{20B9}" + (p*q).toString(),
                                                                                                                                style: TextStyle(
                                                                                                                                    fontSize: ScreenUtil().setSp(18),
                                                                                                                                ),
                                                                                                                            ):Text("Price cannot be lesser than MSP!",
                                                                                                                                style: TextStyle(
                                                                                                                                    fontSize: ScreenUtil().setSp(18),
                                                                                                                                    color: Colors.red,
                                                                                                                                ),
                                                                                                                            ),
                                                                                                                        ),
                                                                                                                    ],
                                                                                                                ),
                                                                                                            ),
                                                                                                        ],
                                                                                                    ),
                                                                                                );
                                                                                            }
                                                                                    );
                                                                                },
                                                                            );
                                                                        }
                                                                    },
                                                                    child: Row(
                                                                        children: [
                                                                            Expanded(
                                                                                child: Container(
                                                                                    padding: EdgeInsets.fromLTRB(
                                                                                        ScreenUtil().setWidth(10),
                                                                                        ScreenUtil().setHeight(10),
                                                                                        ScreenUtil().setWidth(10),
                                                                                        ScreenUtil().setHeight(10),
                                                                                    ),
                                                                                    decoration: BoxDecoration(
                                                                                        border: Border.all(
                                                                                            width: 0.5,
                                                                                            color: Colors.black,
                                                                                        ),
                                                                                    ),
                                                                                    child: Text(rows[pos].querySelectorAll("td")[0].text.toString().trim()),
                                                                                ),
                                                                            ),
                                                                            Container(
                                                                                padding: EdgeInsets.fromLTRB(
                                                                                    ScreenUtil().setWidth(10),
                                                                                    ScreenUtil().setHeight(10),
                                                                                    ScreenUtil().setWidth(10),
                                                                                    ScreenUtil().setHeight(10),
                                                                                ),
                                                                                width: ScreenUtil().setWidth(90),
                                                                                alignment: Alignment.center,
                                                                                decoration: BoxDecoration(
                                                                                    border: Border.all(
                                                                                        width: 0.5,
                                                                                        color: Colors.black,
                                                                                    ),
                                                                                ),
                                                                                child: Text(rows[pos].querySelectorAll("td")
                                                                                [rows[pos].querySelectorAll("td").length-1].text.toString()),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                );
                                                            }
                                                            return Container();
                                                        },
                                                    ),
                                                ),
                                            );
                                        }
                                    }
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}