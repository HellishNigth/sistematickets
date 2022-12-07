import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: FutureBuilder(
        future: this.getUserEmail(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Text('Cargando...');
          }
          return Text(
            snapshot.data,
            style: TextStyle(fontSize: 12),
          );
        },
      ),
    );
  }

  Future<String?> getUserEmail() async {
    final User? user = auth.currentUser;
    final uid = user!.email;

    return uid;
  }
}
