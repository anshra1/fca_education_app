import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fca_education_app/core/%20services/injection_container.dart';
import 'package:fca_education_app/src/auth/datasources/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((data) => LocalUserModel.fromMap(map: data.data()!));
}
