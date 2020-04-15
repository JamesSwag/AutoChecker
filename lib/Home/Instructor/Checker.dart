import 'dart:async';
import 'package:autochecker/Services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'dart:io';
import 'package:intl/intl.dart';

var now = new DateTime.now();
BeaconBroadcast beaconBroadcast = BeaconBroadcast();

class Checker extends StatefulWidget {
  final String uuid;
  final String reg;
  final String email;
  final String name;

  Checker(
      {Key key,
      @required this.uuid,
      @required this.reg,
      @required this.email,
      @required this.name})
      : super(key: key);
  @override
  _CheckerState createState() => _CheckerState();
}

class _CheckerState extends State<Checker> {
  FireStore _fireStore = FireStore();
  bool _isBroadcasting = false;
  Timer t;
  double val;
  int num;

  Future broadcast() async {
    num = 0;
    val = 0;
    bool isAdvertising = await beaconBroadcast.isAdvertising();
    try {
      await flutterBeacon.initializeAndCheckScanning;
    } catch (e) {}

    if (isAdvertising) {
      beaconBroadcast.stop();
    }

    setState(() {
      _isBroadcasting = true;
    });

    if (Platform.isIOS) {
      beaconBroadcast
          .setUUID(widget.uuid)
          .setMajorId(5)
          .setMinorId(100)
          .start();
    } else {
      beaconBroadcast
          .setUUID(widget.uuid)
          .setMajorId(5)
          .setMinorId(100)
          .setLayout('m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24')
          .setManufacturerId(0x004C)
          .start();
    }

    t = Timer.periodic(Duration(milliseconds: 100), (t) {
      if (num >= 100) {
        t.cancel();
        setState(() {
          _isBroadcasting = false;
        });
        beaconBroadcast.stop();
      } else {
        num++;
        setState(() {
          val = val + 0.01;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String date = DateFormat("dd-MM-yyyy").format(now).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("instructors")
            .document(widget.email)
            .collection("classes")
            .document(widget.reg)
            .collection('attendance')
            .document(widget.reg + date)
            .collection('students')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10.0,
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    title: Text(
                      snapshot.data.documents[index]['lname'] +
                          ', ' +
                          snapshot.data.documents[index]['fname'],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: _isBroadcasting
            ? CircularProgressIndicator(
                value: val,
              )
            : Icon(
                Icons.search,
              ),
        backgroundColor: _isBroadcasting ? Colors.white : Colors.pink,
        onPressed: () async {
          String reg = widget.reg + date;
          await _fireStore.setClassInAttendance(
              widget.name, widget.reg, widget.uuid, widget.email, reg);
          await broadcast();
        },
      ),
    );
  }
}
