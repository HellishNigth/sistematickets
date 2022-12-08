import 'package:cliente_tickets/providers/eventos_provider.dart';
import 'package:flutter/material.dart';

class EstadoEditarPage extends StatefulWidget {
  String id;
  EstadoEditarPage(this.id, {Key? key}) : super(key: key);

  @override
  State<EstadoEditarPage> createState() => _EstadoEditarPageState();
}

class _EstadoEditarPageState extends State<EstadoEditarPage> {
  TextEditingController idCtrl = TextEditingController();
  TextEditingController estadoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Estado de Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: EventosProvider().getEvento(widget.id),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var evento = snapshot.data;
              idCtrl.text = evento['id'].toString();
              estadoCtrl.text = evento['estado'];
              return Form(
                child: Column(
                  children: [
                    Container(
                      child: Text('Editando estado de evento'),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          campoEstado(),
                          botonEditar(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  TextFormField campoEstado() {
    return TextFormField(
      controller: estadoCtrl,
      decoration: InputDecoration(
        labelText: 'Estado Evento',
      ),
    );
  }

  Container botonEditar() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.amber,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit),
            Text('Editar estado de evento'),
          ],
        ),
        onPressed: () async {
          //caputar datos del form
          int id = int.tryParse(idCtrl.text.trim()) ?? 0;
          String estado = estadoCtrl.text.trim();
          //enviar por post al api
          await EventosProvider().editarEstado(id, estado);

          //redireccionar a pagina que lista productos
          Navigator.pop(context);
        },
      ),
    );
  }
}
