import 'package:autochecker/Home/Instructor/CreateClass.dart';
import 'package:autochecker/Home/Instructor/InstructClasses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Broadcast extends StatefulWidget {
  final String em;
  Broadcast({Key key, @required this.em}) : super(key: key);
  @override
  _BroadcastState createState() => _BroadcastState();
}

class _BroadcastState extends State<Broadcast> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text('Home'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              SizedBox(
                width: 50,
              )
            ],
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
                  text: 'Create Class',
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: <Widget>[
              InstructClasses(
                em: widget.em,
              ),
              Create(em: widget.em),
            ],
          )),
    );
  }
}
