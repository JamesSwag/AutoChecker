import 'package:autochecker/Services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Create extends StatefulWidget {
  final String em;
  Create({Key key, @required this.em}) : super(key: key);
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final _formKey = GlobalKey<FormState>();
  var id;
  String className = '';
  String reg = '';
  String str = '';
  var uuid = Uuid();
  var cl = Colors.white;
  FireStore _fireStore = FireStore();

  Future createClass(String reg, String email) async {
    bool ds = await _fireStore.checkClass(reg, email);
    if (ds) {
      id = uuid.v4();
      await _fireStore.setClass(className, reg, id, widget.em);
      setState(() {
        str = 'Class Created Successfully';
        cl = Colors.green;
      });

      return;
    } else {
      setState(() {
        str = 'Class Already Exist';
        cl = Colors.red;
      });

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter name for the class';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      className = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Class Name',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.length != 4) {
                      return 'Please enter a 4 digit code';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      reg = val + widget.em;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Code',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 100,
                  child: FlatButton(
                    child: Text('Create'),
                    color: Colors.pink,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await createClass(reg, widget.em);
                      }
                    },
                  ),
                ),
                Text(str, style: TextStyle(color: cl))
              ],
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      ),
    );
  }
}
