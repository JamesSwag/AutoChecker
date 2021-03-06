import 'package:autochecker/Home/Home.dart';
import 'package:autochecker/Screens/ChooseWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      return Choose();
    } else {
      return Home();
    }
  }
}
