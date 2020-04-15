import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  final databaseReference = Firestore.instance;

  Future deleteDoc(String id, String reg) async {
    await databaseReference
        .collection('instructors')
        .document(id)
        .collection('classes')
        .document(reg)
        .delete();
  }

  Future deleteClass(String id, String reg) async {
    await databaseReference
        .collection('students')
        .document(id)
        .collection('classes')
        .document(reg)
        .delete();
  }

  Future deleteAttendance(String id, String reg) async {
    await databaseReference
        .collection('attendance')
        .document(id)
        .collection('classes')
        .document(reg)
        .delete();
  }

  Future<bool> checkDoc(String em) async {
    DocumentSnapshot ds =
        await databaseReference.collection("instructors").document(em).get();
    if (ds.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkClass(String reg, String em) async {
    DocumentSnapshot ds = await databaseReference
        .collection("instructors")
        .document(em)
        .collection('classes')
        .document(reg)
        .get();
    if (!ds.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkClassCollect(String reg) async {
    String em = reg.substring(4, reg.length).trim();
    DocumentSnapshot cl = await databaseReference
        .collection('instructors')
        .document(em)
        .collection('classes')
        .document(reg)
        .get();
    if (cl.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future setStd(String em, String email, String fname, String lname, String reg,
      String date) async {
    String em = reg.substring(4, reg.length);

    await databaseReference
        .collection("instructors")
        .document(em)
        .collection("classes")
        .document(reg)
        .collection('attendance')
        .document(reg + date)
        .collection('students')
        .document(email)
        .setData({'fname': fname, 'lname': lname, 'email': email});
  }

  Future setStdInClass(
      String email, String fname, String lname, String reg) async {
    String em = reg.substring(4, reg.length);
    await databaseReference
        .collection("instructors")
        .document(em)
        .collection("classes")
        .document(reg)
        .collection('students')
        .document(email)
        .setData({'fname': fname, 'lname': lname, 'email': email});
  }

  Future createStd(String email, String fname, String lname) async {
    await databaseReference
        .collection("students")
        .document(email)
        .setData({'fname': fname, 'lname': lname, 'email': email});
  }

  Future setClass(String name, String reg, var uuid, String em) async {
    await databaseReference
        .collection("instructors")
        .document(em)
        .collection("classes")
        .document(reg)
        .setData({'name': name, 'Id': reg, 'uuid': uuid, 'InstructorID': em});
  }

  Future setClassInClassCollection(
      String name, String reg, var uuid, String em) async {
    await databaseReference
        .collection("classes")
        .document(reg)
        .setData({'name': name, 'Id': reg, 'uuid': uuid, 'InstructorID': em});
  }

  Future setClassInAttendance(
      String name, String reg, var uuid, String em, String regCode) async {
    await databaseReference
        .collection('instructors')
        .document(em)
        .collection('classes')
        .document(reg)
        .collection('attendance')
        .document(regCode)
        .setData({'name': name, 'Id': reg, 'uuid': uuid, 'InstructorID': em});
  }

  Future<String> getUuid(reg) async {
    String id;
    await databaseReference.collection("classes").document(reg).get()
        // ignore: non_constant_identifier_names
        .then((DocumentSnapshot) {
      id = DocumentSnapshot.data['uuid'].toString();
    });
    return id;
  }

  Future SetClassStd(reg, em) async {
    String name;
    String inId;
    String uuid;
    String email = reg.substring(4, reg.length);
    await databaseReference
        .collection("instructors")
        .document(email)
        .collection('classes')
        .document(reg)
        .get()
        .then((DocumentSnapshot) {
      name = DocumentSnapshot.data['name'].toString();
      inId = DocumentSnapshot.data['InstructorID'].toString();
      uuid = DocumentSnapshot.data['uuid'].toString();
    });

    await databaseReference
        .collection("students")
        .document(em)
        .collection("classes")
        .document(reg)
        .setData({'name': name, 'Id': reg, 'uuid': uuid, 'InstructorID': inId});

    return;
  }
}
