import 'package:autochecker/Home/Instructor/Checker.dart';
import 'package:autochecker/Services/firestore.dart';
import 'package:autochecker/Services/prefs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InstructClasses extends StatefulWidget {
  final String em;
  InstructClasses({Key key, @required this.em}) : super(key: key);
  @override
  _InstructClassesState createState() => _InstructClassesState();
}

class _InstructClassesState extends State<InstructClasses> {
  FireStore _fr = FireStore();
  Prefs prefs = Prefs();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("instructors")
          .document(widget.em)
          .collection("classes")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.data.documents.length == 0) {
            return Center(
              child: Text('You Have No Classes At The Moment'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return Container(
                height: 80,
                child: Card(
                  elevation: 10.0,
                  child: ListTile(
                    title: Text(
                      snapshot.data.documents[index]['name'],
                    ),
                    subtitle: Text(snapshot.data.documents[index]['Id']),
                    leading: Icon(Icons.class_, color: Colors.black),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        try {
                          await _fr.deleteDoc(
                              snapshot.data.documents[index]['InstructorID'],
                              snapshot.data.documents[index]['Id']);
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Checker(
                            uuid: snapshot.data.documents[index]['uuid'],
                            reg: snapshot.data.documents[index]['Id'],
                            email: widget.em,
                            name: snapshot.data.documents[index]['name'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
