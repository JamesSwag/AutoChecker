import 'package:autochecker/Services/auth.dart';
import 'package:autochecker/Services/firestore.dart';
import 'package:autochecker/Services/prefs.dart';
import 'package:flutter/material.dart';
import '../Home/Student/ScanningPage.dart';

class StudentSignIn extends StatefulWidget {
  @override
  _StudentSignInState createState() => _StudentSignInState();
}

class _StudentSignInState extends State<StudentSignIn> {
  String email = '';
  String fname = '';
  String lname = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  Prefs _prefs = Prefs();
  FireStore _fr = FireStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Student Register'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
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
                        _fr.createStd(email, fname, lname);
                      }
                    },
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
