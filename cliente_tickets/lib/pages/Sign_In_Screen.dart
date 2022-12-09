//SignInScreen

import 'package:cliente_tickets/pages/admin/agregar_eventos_page.dart';
import 'package:cliente_tickets/pages/admin/listar_eventos_page.dart';
import 'package:cliente_tickets/pages/clientes/home_cliente_page.dart';
import 'package:cliente_tickets/pages/clientes/ver_noticias_page.dart';
import 'package:cliente_tickets/providers/clientes_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'admin/home_admin_page.dart';
import 'home_page.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.red,
            ],
          ),
        ),
        child: Card(
          margin: EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(MdiIcons.ticket),
              Text(
                "Tickets For Tickets",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  color: Colors.teal[100],
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/googleimage.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Sign In with Google")
                    ],
                  ),

                  // by onpressed we call the function signup function

                  onPressed: () {
                    signup(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      String? userEmail = user!.email;
      if (result != null) {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => Text(rolUsuario)));
        if (userEmail == 'grupodambik@gmail.com') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeAdminPage()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => EventosAgregarPage()));
        }
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }
}
