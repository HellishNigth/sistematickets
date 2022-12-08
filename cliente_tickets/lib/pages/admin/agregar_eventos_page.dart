import 'package:cliente_tickets/providers/eventos_provider.dart';
import 'package:flutter/material.dart';

class EventosAgregarPage extends StatefulWidget {
  const EventosAgregarPage({Key? key}) : super(key: key);

  @override
  State<EventosAgregarPage> createState() => _EventosAgregarPageState();
}

class _EventosAgregarPageState extends State<EventosAgregarPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreEveCtrl = TextEditingController();
  TextEditingController detalleEveCtrl = TextEditingController();
  TextEditingController ubicacionEveCtrl = TextEditingController();
  TextEditingController precioEveCtrl = TextEditingController();
  TextEditingController cantidadTicketCtrl = TextEditingController();
  TextEditingController estadoCtrl = TextEditingController();
  TextEditingController fechaEveCtrl = TextEditingController();

  String errNombre = '';
  String errDetalle = '';
  String errUbicacion = '';
  String errPrecio = '';
  String errCantidad = '';
  String errEstado = '';
  String errFecha = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Evento',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              campoNombre(),
              MostrarErrores(errNombre),
              campoDetalle(),
              MostrarErrores(errDetalle),
              campoUbicacion(),
              MostrarErrores(errUbicacion),
              campoPrecio(),
              MostrarErrores(errPrecio),
              campoCantidad(),
              MostrarErrores(errCantidad),
              campoEstado(),
              MostrarErrores(errEstado),
              campoFecha(),
              MostrarErrores(errFecha),
              botonAgregar(),
            ],
          ),
        ),
      ),
    );
  }

  Container MostrarErrores(error) {
    return Container(
      width: double.infinity,
      child: Text(
        error,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Container botonAgregar() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            Text('Agregar Evento'),
          ],
        ),
        onPressed: () async {
          String nombre = nombreEveCtrl.text.trim();
          String detalle = detalleEveCtrl.text.trim();
          String ubicacion = ubicacionEveCtrl.text.trim();
          int precio = int.tryParse(precioEveCtrl.text.trim()) ?? 0;
          int cantidad = int.tryParse(cantidadTicketCtrl.text.trim()) ?? 0;
          String estado = estadoCtrl.text.trim();
          DateTime fecha = DateTime.parse(fechaEveCtrl.text.trim());

          var respuesta = await EventosProvider().agregarEvento(
              nombre, detalle, ubicacion, precio, cantidad, estado, fecha);
          if (respuesta['messages'] != null) {
            var errores = respuesta['errors'];
            errNombre =
                errores['nombreEve'] != null ? errores['nombreEve'][0] : '';
            errDetalle =
                errores['detalleEve'] != null ? errores['detalleEve'][0] : '';
            errUbicacion = errores['ubicacionEve'] != null
                ? errores['ubicacionEve'][0]
                : '';
            errPrecio =
                errores['precioEve'] != null ? errores['precioEve'][0] : '';
            errCantidad = errores['cantidadTicket'] != null
                ? errores['cantidadTicket'][0]
                : '';
            errEstado = errores['estado'] != null ? errores['estado'][0] : '';
            errFecha =
                errores['fechaEve'] != null ? errores['fechaEve'][0] : '';
            setState(() {});
            return;
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  TextFormField campoFecha() {
    return TextFormField(
      controller: fechaEveCtrl,
      decoration: InputDecoration(
        label: Text('Fecha del Evento'),
      ),
      keyboardType: TextInputType.datetime,
    );
  }

  TextFormField campoEstado() {
    return TextFormField(
      controller: estadoCtrl,
      decoration: InputDecoration(
        label: Text('Estado del Evento'),
      ),
    );
  }

  TextFormField campoCantidad() {
    return TextFormField(
      controller: cantidadTicketCtrl,
      decoration: InputDecoration(
        label: Text('Cantidad de tickets'),
      ),
    );
  }

  TextFormField campoPrecio() {
    return TextFormField(
      controller: precioEveCtrl,
      decoration: InputDecoration(
        label: Text('Precio del Evento'),
      ),
      keyboardType: TextInputType.number,
    );
  }

  TextFormField campoUbicacion() {
    return TextFormField(
      controller: ubicacionEveCtrl,
      decoration: InputDecoration(
        label: Text('Ubicación del Evento'),
      ),
    );
  }

  TextFormField campoDetalle() {
    return TextFormField(
      controller: detalleEveCtrl,
      decoration: InputDecoration(
        label: Text('Detalle del Evento'),
      ),
    );
  }

  TextFormField campoNombre() {
    return TextFormField(
      controller: nombreEveCtrl,
      decoration: InputDecoration(
        label: Text('Nombre del Evento'),
      ),
    );
  }
}
