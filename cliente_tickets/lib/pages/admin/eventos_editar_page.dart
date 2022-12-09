import 'package:cliente_tickets/providers/eventos_provider.dart';
import 'package:flutter/material.dart';

class EventosEditarPage extends StatefulWidget {
  String id;
  EventosEditarPage(this.id, {Key? key}) : super(key: key);

  @override
  State<EventosEditarPage> createState() => _EditarEventosPageState();
}

class _EditarEventosPageState extends State<EventosEditarPage> {
  TextEditingController idCtrl = TextEditingController();
  TextEditingController nombreEveCtrl = TextEditingController();
  TextEditingController detalleEveCtrl = TextEditingController();
  TextEditingController ubicacionEveCtrl = TextEditingController();
  TextEditingController precioEveCtrl = TextEditingController();
  TextEditingController cantidadTicketCtrl = TextEditingController();
  TextEditingController estadoCtrl = TextEditingController();
  TextEditingController fechaEveCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Evento'),
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
              nombreEveCtrl.text = evento['nombreEve'];
              detalleEveCtrl.text = evento['detalleEve'];
              ubicacionEveCtrl.text = evento['ubicacionEve'];
              precioEveCtrl.text = evento['precioEve'].toString();
              cantidadTicketCtrl.text = evento['cantidadTicket'].toString();
              estadoCtrl.text = evento['estado'];
              fechaEveCtrl.text = evento['fechaEve'];
              return Form(
                child: Column(
                  children: [
                    Container(
                      child: Text('Editando evento'),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          campoNombreEve(),
                          campoDetalleEve(),
                          campoUbicacionEve(),
                          campoPrecioEve(),
                          campocantidadTicket(),
                          campoEstado(),
                          campoFechaEve(),
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

  TextFormField campoNombreEve() {
    return TextFormField(
      controller: nombreEveCtrl,
      decoration: InputDecoration(
        labelText: 'Nombre Evento',
      ),
    );
  }

  TextFormField campoDetalleEve() {
    return TextFormField(
      controller: detalleEveCtrl,
      decoration: InputDecoration(
        labelText: 'Detalle Evento',
      ),
    );
  }

  TextFormField campoUbicacionEve() {
    return TextFormField(
      controller: ubicacionEveCtrl,
      decoration: InputDecoration(
        labelText: 'Ubicación Evento',
      ),
    );
  }

  TextFormField campoPrecioEve() {
    return TextFormField(
      controller: precioEveCtrl,
      decoration: InputDecoration(
        labelText: 'Precio Evento',
      ),
      keyboardType: TextInputType.number,
    );
  }

  TextFormField campocantidadTicket() {
    return TextFormField(
      controller: cantidadTicketCtrl,
      decoration: InputDecoration(
        labelText: 'Cantidad de tickets para Evento',
      ),
      keyboardType: TextInputType.number,
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

  //Corregir fecha evento TO-DO
  TextFormField campoFechaEve() {
    return TextFormField(
      controller: fechaEveCtrl,
      decoration: InputDecoration(
        labelText: 'Fecha Evento',
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
            Text('Editar Evento'),
          ],
        ),
        onPressed: () async {
          //caputar datos del form
          int id = int.tryParse(idCtrl.text.trim()) ?? 0;
          String nombreEve = nombreEveCtrl.text.trim();
          String detalleEve = detalleEveCtrl.text.trim();
          String ubicacionEve = ubicacionEveCtrl.text.trim();
          int precioEve = int.tryParse(precioEveCtrl.text.trim()) ?? 0;
          int cantidadTicket =
              int.tryParse(cantidadTicketCtrl.text.trim()) ?? 0;
          String estado = estadoCtrl.text.trim();
          String fechaEve = fechaEveCtrl.text.trim();
          //enviar por post al api
          await EventosProvider().editarEvento(id, nombreEve, detalleEve,
              ubicacionEve, precioEve, cantidadTicket, estado, fechaEve);

          //redireccionar a pagina que lista productos
          Navigator.pop(context);
        },
      ),
    );
  }
}
