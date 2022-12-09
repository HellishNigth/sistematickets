import 'package:cliente_tickets/pages/clientes/ver_noticias_page.dart';
import 'package:cliente_tickets/services/firestore_service.dart';
import 'package:flutter/material.dart';

class AgregarNoticiaPage extends StatefulWidget {
  AgregarNoticiaPage({Key? key}) : super(key: key);

  @override
  State<AgregarNoticiaPage> createState() => _AgregarNoticiaPageState();
}

class _AgregarNoticiaPageState extends State<AgregarNoticiaPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController detalleCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
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
                  label: Text('Titulo'),
                ),
              ),
              TextFormField(
                controller: detalleCtrl,
                decoration: InputDecoration(
                  label: Text('Detalle'),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  child: Text('Agregar Noticia'),
                  onPressed: () {
                    FirestroreService().agregarNoticia(
                      tituloCtrl.text.trim(),
                      detalleCtrl.text.trim(),
                    );
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerNoticiasPage()));
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
