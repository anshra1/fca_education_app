import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fca_education_app/src/auth/domain/entites/local_user.dart';

class Person {
  Person({
    required String name,
    required int age,
  })  : _name = name,
        _age = age;

  String _name;
  int _age;

  String get names => _name;
  int get ages => _age;

  set name(String newName) {
    _name = newName;
  }

  set age(int newAge) {
    _age = newAge;
  }
}

const tUser = LocalUser.empty();

void main() async {
  final firestore = FirebaseFirestore.instance;
  final docRef = await firestore.collection('users').add(tUser.toMap());
  var s = docRef.id;
  
}
