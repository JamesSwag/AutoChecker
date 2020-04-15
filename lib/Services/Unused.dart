//This where parts of code I may use in the future go

/*StreamBuilder<DocumentSnapshot>(
stream: Firestore.instance
    .collection("instructors")
    .document(snapshot.data)
    .snapshots(),
// ignore: missing_return
builder: (context, snapshot) {
if (!snapshot.hasData) {
return Center(
child: Text("Loading...."),
);
// ignore: unnecessary_statements
} else {
if (snapshot.data.exists) {
return Broadcast();
} else {
return Scanning();
}
}
},
);*/

/*StreamProvider<FirebaseUser>.value(
value: _auth.user,
child: MaterialApp(
home: Wrapper(),
),
);*/
