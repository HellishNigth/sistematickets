import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('HOLA'),
    );
  }

  Future<String?> getUserEmail() async {
    final User? user = auth.currentUser;
    final uid = user!.email;

    return uid;
  }
}
