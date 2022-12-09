import 'package:cliente_tickets/pages/Sign_In_Screen.dart';
import 'package:cliente_tickets/providers/eventos_provider.dart';
import 'package:cliente_tickets/services/firestore_service.dart';
import 'package:cliente_tickets/widget/tile_detalle_evento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

class VerDetalleEventosPage extends StatelessWidget {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  int id = 1;
  // GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    // scopes: <String>[
      // 'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    // ],
  //);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ver detalle evento'),
          // actions: [
          //   PopupMenuButton(
          //     itemBuilder: (context) => [
          //       PopupMenuItem(
          //         value: 'logout',
          //         child: Text('Cerrar Sesión'),
          //       ),
          //     ],
          //     onSelected: (opcionSeleccionada) {
          //       if (opcionSeleccionada == 'logout') {
          //         _handleSignOut;
          //         Navigator.pushReplacement(context,
          //             MaterialPageRoute(builder: (context) => SignInScreen()));
          //       }
          //     },
          //   ),
          // ],
        ),
        body: Expanded(
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: FutureBuilder(
              future: EventosProvider().getDetalleEvento(id),
              builder: (context, AsyncSnapshot snap) {
                //esperando data
                if (!snap.hasData || snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                //data recibida, mostrar
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snap.data.length,
                  itemBuilder: (context, index) {
                    var detalleId = snap.data[index];
                    return TileDetalleEvento(evento: detalleId);
                  },
                );
              },
            ),
          ),
    ));
  }

  // Future<void> _handleSignOut() => _googleSignIn.disconnect();

  // Future<String?> getUserEmail() async {
  //   final User? user = auth.currentUser;
  //   final uid = user!.email;

  //   return uid;
  // }
}
