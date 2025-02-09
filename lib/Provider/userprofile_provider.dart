import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _email = "";
  String _name = "";
  String _initial = "";

  String get email => _email;
  String get name => _name;
  String get initial => _initial;

  void setUserInfo(String email, String name) {
    _email = email;
    _name = name;
    _initial = name.isNotEmpty ? name[0].toUpperCase() : "?";
    notifyListeners();
  }

  Future<void> fetchUserInfo() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          _email = user.email ?? "";
          _name = userDoc.data()?['name'] ?? user.email?.split('@')[0] ?? "No Name";
          _initial = _name.isNotEmpty ? _name[0].toUpperCase() : "?";
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error fetching user info: $e");
    }
  }
}