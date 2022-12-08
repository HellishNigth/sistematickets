import 'package:cliente_tickets/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoriciasAgregarPage extends StatefulWidget {
  const NoriciasAgregarPage({Key? key}) : super(key: key);

  @override
  State<NoriciasAgregarPage> createState() => _NoriciasAgregarPageState();
}

class _NoriciasAgregarPageState extends State<NoriciasAgregarPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController detalleCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Noticia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tituloCtrl,
                decoration: InputDecoration(
                  label: Text('Titulo Noticia'),
                ),
              ),
              TextFormField(
                controller: detalleCtrl,
                decoration: InputDecoration(
                  label: Text('Detalle Noticia'),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  child: Text('Agregar Noticia'),
                  onPressed: () {
                    FirestroreService().agregarNoticia(
                      tituloCtrl.text.trim(),
                      detalleCtrl.text.trim(),
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}