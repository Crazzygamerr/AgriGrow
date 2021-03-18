import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

    static const String login = "login";
    static const String emailKey = "email";
    static const String expertKey = "expert";

    static Future setUser(String email, bool b, bool doc) async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(emailKey, email);
        pref.setBool(login, b);
        pref.setBool(expertKey, doc);
    }

    static Future<bool> getUserLogin() async {
        try {
            final SharedPreferences pref = await SharedPreferences.getInstance();
            if (pref.containsKey(login))
                return pref.getBool(login);
            else
                return false;
        } on Exception catch (e) {
            Fluttertoast.showToast(
                msg: "$e",
                textColor: Colors.black,
                fontSize: 20,
                toastLength: Toast.LENGTH_LONG,
            );
            return false;
        }
    }

    static Future<String> getEmail() async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        return pref.getString(emailKey);
    }

    static Future<bool> getDoc() async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        return pref.getBool(expertKey);
    }

    static Future setUserLogin(bool b) async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool(login, b);
    }

}