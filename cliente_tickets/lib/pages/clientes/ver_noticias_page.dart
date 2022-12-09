import 'package:cliente_tickets/pages/Sign_In_Screen.dart';
import 'package:cliente_tickets/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class VerNoticiasPage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ver Noticias'),
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                }
              },
            ),
          ],
        ),
        body: StreamBuilder(
            stream: FirestroreService().noticias(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, prueba) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, prueba) {
                  var noticiaId = snapshot.data!.docs[prueba];
                  return ListTile(
                    leading: Icon(
                      MdiIcons.cube,
                      color: Colors.deepPurple,
                    ),
                    title: Text(noticiaId['tituloNoticia']),
                    subtitle: Text(noticiaId['detalleNoticia']),
                  );
                },
              );
            }));
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Future<String?> getUserEmail() async {
    final User? user = auth.currentUser;
    final uid = user!.email;

    return uid;
  }
}
