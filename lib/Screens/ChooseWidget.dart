import 'package:autochecker/Registration/InstructorRegistration.dart';
import 'package:autochecker/Registration/StudentRegister.dart';
import 'package:flutter/material.dart';

class Choose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 140,
              ),
              Text(
                'Select User Type',
                style: TextStyle(color: Colors.blueGrey),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentSignIn()),
                  );
                },
                icon: Icon(Icons.person),
                iconSize: 40.0,
                color: Colors.blueGrey,
              ),
              Text(
                'Student',
                style: TextStyle(color: Colors.blueGrey),
              ),
              SizedBox(
                height: 30.0,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Instructor()),
                  );
                },
                icon: Icon(Icons.school),
                iconSize: 40.0,
                color: Colors.blueGrey,
              ),
              Text(
                'Instructor',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
