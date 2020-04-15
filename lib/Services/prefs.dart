import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  int _id;

  Future<void> setPref(String email, String fname, String lname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('fname', fname);
    await prefs.setString('lname', lname);
    return;
  }

  Future setReg(String reg) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('regCode', reg);
  }

  Future<String> getReg() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String reg = prefs.getString('regCode');
    return reg;
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    return email;
  }

  Future<String> getFname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String fname = prefs.getString('fname');
    return fname;
  }

  Future<String> getLname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String lname = prefs.getString('lname');
    return lname;
  }

  Future setUuids(List<String> uuids) async {
    List<String> list;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('uuids') == null) {
      await prefs.setStringList('uuids', uuids);
      return;
    } else {
      if (uuids.isEmpty) {
        return;
      } else {
        list = prefs.getStringList('uuids');
        for (int i = 0; i < uuids.length; i++) {
          list.add(uuids[i]);
        }
        await prefs.setStringList('uuids', list);
        return;
      }
    }
  }

  Future setClass(List<String> classes) async {
    List<String> list;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('classes') == null) {
      await prefs.setStringList('classes', classes);
    } else {
      if (classes.isEmpty) {
        return;
      } else {
        list = prefs.getStringList('classes');
        for (int i = 0; i < classes.length; i++) {
          list.add(classes[i]);
        }
        await prefs.setStringList('classes', list);
        return;
      }
    }
  }

  Future<List<String>> getUuids() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    if (prefs.getStringList('uuids') == null) {
      return list;
    } else {
      list = prefs.getStringList('uuids');
      return list;
    }
  }

  Future<List<String>> getClasses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    if (prefs.getStringList('classes') == null) {
      return list;
    } else {
      list = prefs.getStringList('classes');
      return list;
    }
  }
}
