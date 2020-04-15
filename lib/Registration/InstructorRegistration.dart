import 'package:autochecker/Services/auth.dart';
import 'package:autochecker/Services/prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Home/Instructor/Broadcast.dart';

class Instructor extends StatefulWidget {
  @override
  _InstructorState createState() => _InstructorState();
}

class _InstructorState extends State<Instructor> {
  final databaseReference = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String fname = '';
  String lname = '';
  String school = '';
  int _id = 1;
  final Prefs _prefs = Prefs();
  final AuthService _auth = AuthService();
  Future setInstructor(String email, String fname, String lname) async {
    await databaseReference
        .collection("instructors")
        .document(email)
        .setData({'email': email, 'fname': fname, 'lname': lname});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Instructor Registration'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please Enter a Valid Email';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please Enter Your First Name';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      fname = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'First Name',
                  ),
                ),
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please Enter Your Last Name';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      lname = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                  ),
                ),
                Container(
                  width: 100,
                  child: FlatButton(
                    child: Text("Register"),
                    color: Colors.pink,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await _prefs.setPref(email, fname, lname);
                        dynamic user = await _auth.signIn();
                        await setInstructor(email, fname, lname);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      ),
    );
  }
}
