import 'dart:async';
import 'package:autochecker/Services/firestore.dart';
import 'package:autochecker/Services/prefs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';

var now = new DateTime.now();

class Classes extends StatefulWidget {
  final String em;
  Classes({Key key, @required this.em}) : super(key: key);
  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  FireStore _fr = FireStore();
  Timer t;
  Prefs prefs = Prefs();
  String email = '';
  String fname = '';
  String lname = '';
  StreamSubscription<RangingResult> _streamRanging;

  final regions = <Region>[];
  ProgressDialog pr;
  String date = DateFormat("dd-MM-yyyy").format(now).toString();

  Future<bool> getStd(String em, String fn, String ln) async {
    try {
      await flutterBeacon.initializeAndCheckScanning;
      email = await prefs.getEmail();
      fname = await prefs.getFname();
      lname = await prefs.getLname();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future ranging(String uuid, String reg, String em) async {
    if (regions.isNotEmpty) {
      regions.clear();
    }
    regions.add(Region(
      identifier: 'Apple Locate',
      proximityUUID: uuid,
    ));

    t = Timer(Duration(milliseconds: 6000), () {
      _streamRanging.cancel();
      pr.update(
        message: 'Class Not Found',
        progressWidget: Icon(
          Icons.sms_failed,
          color: Colors.red,
        ),
      );
    });

    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      if (result.beacons.isNotEmpty) {
        t.cancel();
        _fr.setStd(em, email, fname, lname, reg, date);
        _streamRanging.cancel();
        pr.update(
          message: 'Class Found!',
          progressWidget: Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    return Scaffold(
      body: FutureBuilder(
        future: getStd(email, fname, lname),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return StreamBuilder(
              stream: Firestore.instance
                  .collection("students")
                  .document(widget.em)
                  .collection("classes")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data.documents.isEmpty) {
                    return Center(
                      child: Text('You Have No Classes'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 6.0,
                        child: ListTile(
                          leading: Icon(
                            Icons.class_,
                            color: Colors.black,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await _fr.deleteClass(
                                  email, snapshot.data.documents[index]['Id']);
                            },
                          ),
                          title: Text(
                            snapshot.data.documents[index]['name'],
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          subtitle: Text(
                              snapshot.data.documents[index]['InstructorID']),
                          onTap: () async {
                            pr.style(
                                message: '  Scanning...',
                                progressWidget: CircularProgressIndicator(),
                                elevation: 10.0);
                            await pr.show();
                            ranging(
                                snapshot.data.documents[index]['uuid'],
                                snapshot.data.documents[index]['Id'],
                                snapshot.data.documents[index]['InstructorID']);
                          },
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
