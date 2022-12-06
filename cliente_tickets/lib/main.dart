import 'package:cliente_tickets/authenticator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:AutenticacionDAM()));
}

class AutenticacionDAM extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async{
            User? user = await Authenticator.iniciarSesion(
              context: context
            );
            print(user?.displayName);
          },
          color: Colors.blue,
          child: Icon(FontAwesomeIcons.google),
          textColor: Colors.white,
          ),),
      ),
    );
  }
}