import 'package:cliente_tickets/pages/admin/agregar_eventos_page.dart';
import 'package:cliente_tickets/pages/admin/listar_eventos_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({Key? key}) : super(key: key);

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int paginaSel = 0;
  final paginas = [ListarEventosPage(), EventosAgregarPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets For Tickets'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Text('Cerrar Sesión'),
              ),
            ],
            onSelected: (opcionSeleccionada) {
              if (opcionSeleccionada == 'logout') {
                _handleSignOut;
              }
            },
          ),
        ],
      ),
      body: paginas[paginaSel],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: paginaSel,
        onTap: (index) {
          setState(() {
            paginaSel = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.cube),
            label: 'Eventos',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.cube),
            label: 'Agregar Evento',
          )
        ],
      ),
    );
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
}
