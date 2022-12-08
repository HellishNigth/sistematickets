import 'package:cliente_tickets/providers/clientes_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/home_admin_page.dart';
import 'clientes/home_cliente_page.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Chupalo'),
    );
  }

  Future<String?> getUserEmail() async {
    final User? user = auth.currentUser;
    final uid = user!.email;

    return uid;
  }
}
