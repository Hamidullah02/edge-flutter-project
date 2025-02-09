import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Provider/userprofile_provider.dart';
import 'package:recipe_app/views/settings.dart';

class AuthService {
  // static Future<void> addDefaultAdmin() async {
  //   const String adminEmail = 'admin@gmail.com';
  //   const String adminPassword = '123456';
  //
  //   try {
  //     final adminUser = await FirebaseAuth.instance.fetchSignInMethodsForEmail(adminEmail);
  //     if (adminUser.isEmpty) {
  //       final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: adminEmail,
  //         password: adminPassword,
  //       );
  //
  //       await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
  //         'email': adminEmail,
  //         'isAdmin': true,
  //         'createdAt': FieldValue.serverTimestamp(),
  //       });
  //
  //       print('Default admin created successfully');
  //     } else {
  //       print('Admin already exists');
  //     }
  //   } catch (e) {
  //     print('Error creating default admin: $e');
  //   }
  // }

  static Future<User?> signInWithEmailAndPassword(
      String email, String password,BuildContext context) async {
    // final usermail = Provider.of<UserProvider>(email as BuildContext);

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // usermail.setMail(email);
      await Provider.of<UserProvider>(context, listen: false).fetchUserInfo();
      return userCredential.user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  static Future<User?> registerWithEmailAndPassword(
      String email, String password,BuildContext context) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'isAdmin': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await Provider.of<UserProvider>(context, listen: false).fetchUserInfo();
      return userCredential.user;
    } catch (e) {
      print('Error registering: $e');
      return null;
    }
  }
}
