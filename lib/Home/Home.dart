import 'package:autochecker/Home/Instructor/Broadcast.dart';
import 'package:autochecker/Home/Student/ScanningPage.dart';
import 'package:autochecker/Services/firestore.dart';
import 'package:autochecker/Services/prefs.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Prefs prefs = Prefs();
  FireStore fr = FireStore();
  String em = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: prefs.getEmail(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            em = snapshot.data;
            return FutureBuilder(
              future: fr.checkDoc(snapshot.data),
              // ignore: missing_return
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                    // ignore: missing_return
                  );
                } else {
                  if (snapshot.data) {
                    return Broadcast(em: em);
                  } else {
                    return Scanning(em: em);
                  }
                }
              },
            );
          } else {
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}
