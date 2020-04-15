import 'package:autochecker/Home/Student/ClassRegister.dart';
import 'package:autochecker/Home/Student/StudentClasses.dart';
import 'package:flutter/material.dart';

class Scanning extends StatefulWidget {
  final String em;
  Scanning({Key key, @required this.em}) : super(key: key);
  @override
  _ScanningState createState() => _ScanningState();
}

class _ScanningState extends State<Scanning> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Home'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.pink,
            unselectedLabelColor: Colors.blueGrey[200],
            indicatorWeight: 5.0,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.class_),
                text: 'Classes',
              ),
              Tab(
                icon: Icon(Icons.add),
                text: 'Add Class',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Classes(em: widget.em),
            Register(
              em: widget.em,
            ),
          ],
        ),
      ),
    );
  }
}
