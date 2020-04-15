import 'package:autochecker/Services/firestore.dart';
import 'package:autochecker/Services/prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final String em;
  Register({Key key, @required this.em}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final databaseReference = Firestore.instance;
  FireStore _fireStore = FireStore();
  Prefs _prefs = Prefs();
  String regCode = '';
  String email = '';
  String fname = '';
  String lname = '';
  String txt = '';
  var cl;
  String n = 'hello';

  Future regClass(String reg) async {
    try {
      bool ds = await _fireStore.checkClassCollect(reg);
      if (ds) {
        setState(() {
          txt = 'Class Registration Complete';
          cl = Colors.green;
        });
        email = await _prefs.getEmail();
        fname = await _prefs.getFname();
        lname = await _prefs.getLname();
        await _fireStore.setStdInClass(email, fname, lname, reg);
        await _fireStore.SetClassStd(reg, widget.em);

        return;
      } else {
        setState(() {
          txt = 'Class Not Found';
          cl = Colors.red;
        });
        return;
      }
    } catch (e) {
      setState(() {
        txt = 'Class Not Found';
        cl = Colors.red;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Code';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      regCode = val;
                    });
                  },
                  decoration:
                      InputDecoration(hintText: 'Enter Registration Code'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  child: RaisedButton(
                    child: Text('Register'),
                    color: Colors.pink,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await regClass(regCode.trim());
                      }
                    },
                  ),
                ),
                Text(
                  txt,
                  style: TextStyle(color: cl),
                ),
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        ),
      ),
    );
  }
}
