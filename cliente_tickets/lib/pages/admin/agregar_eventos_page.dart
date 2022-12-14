import 'package:cliente_tickets/pages/admin/home_admin_page.dart';
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
  int _step = 0;

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
          child: Expanded(
            child: Stepper(
              steps: [
                Step(
                  title: Text('Paso 1'),
                  content: campoNombre(),
                  label: MostrarErrores(errNombre),
                ),
                Step(
                  title: Text('Paso 2'),
                  content: campoDetalle(),
                  label: MostrarErrores(errDetalle),
                ),
                Step(
                  title: Text('Paso 3'),
                  content: campoUbicacion(),
                  label: MostrarErrores(errUbicacion),
                ),
                Step(
                  title: Text('Paso 4'),
                  content: campoPrecio(),
                  label: MostrarErrores(errPrecio),
                ),
                Step(
                  title: Text('Paso 5'),
                  content: campoCantidad(),
                  label: MostrarErrores(errCantidad),
                ),
                Step(
                  title: Text('Paso 6'),
                  content: campoEstado(),
                  label: MostrarErrores(errEstado),
                ),
                Step(
                  title: Text('Paso 7'),
                  content: campoFecha(),
                  label: MostrarErrores(errFecha),
                ),
                Step(title: Text('Paso 8'), content: botonAgregar()),
              ],
              currentStep: _step,
              onStepTapped: (index) {
                setState(() => _step = index);
              },
              onStepContinue: () {
                if (_step != 7) {
                  setState(() => _step++);
                }
              },
              onStepCancel: () {
                if (_step != 0) {
                  setState(() => _step--);
                }
              },
            ),
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
          String nombreEve = nombreEveCtrl.text.trim();
          String detalleEve = detalleEveCtrl.text.trim();
          String ubicacionEve = ubicacionEveCtrl.text.trim();
          int precioEve = int.tryParse(precioEveCtrl.text.trim()) ?? 0;
          int cantidadTicket =
              int.tryParse(cantidadTicketCtrl.text.trim()) ?? 0;
          String estado = estadoCtrl.text.trim();
          String fechaEve = fechaEveCtrl.text.trim();

          var respuesta = await EventosProvider().agregarEvento(
              nombreEve,
              detalleEve,
              ubicacionEve,
              precioEve,
              cantidadTicket,
              estado,
              fechaEve);
          // if (respuesta['messages'] != null) {
          //   var errores = respuesta['errors'];
          //   errNombre =
          //       errores['nombreEve'] != null ? errores['nombreEve'][0] : '';
          //   errDetalle =
          //       errores['detalleEve'] != null ? errores['detalleEve'][0] : '';
          //   errUbicacion = errores['ubicacionEve'] != null
          //       ? errores['ubicacionEve'][0]
          //       : '';
          //   errPrecio =
          //       errores['precioEve'] != null ? errores['precioEve'][0] : '';
          //   errCantidad = errores['cantidadTicket'] != null
          //       ? errores['cantidadTicket'][0]
          //       : '';
          //   errEstado = errores['estado'] != null ? errores['estado'][0] : '';
          //   errFecha =
          //       errores['fechaEve'] != null ? errores['fechaEve'][0] : '';
          //   setState(() {});
          //   return;
          // }
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeAdminPage()));
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
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su estado';
        }
        return null;
      },
    );
  }

  TextFormField campoCantidad() {
    return TextFormField(
      controller: cantidadTicketCtrl,
      decoration: InputDecoration(
        label: Text('Cantidad de tickets'),
      ),
      keyboardType: TextInputType.number,
    );
  }

  TextFormField campoPrecio() {
    return TextFormField(
      controller: precioEveCtrl,
      decoration: InputDecoration(
        label: Text('Precio del Evento'),
      ),
      keyboardType: TextInputType.number,
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su Precio';
        }
        return null;
      },
    );
  }

  TextFormField campoUbicacion() {
    return TextFormField(
      controller: ubicacionEveCtrl,
      decoration: InputDecoration(
        label: Text('Ubicaci??n del Evento'),
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique su Ubicacion';
        }
        return null;
      },
    );
  }

  TextFormField campoDetalle() {
    return TextFormField(
      controller: detalleEveCtrl,
      decoration: InputDecoration(
        label: Text('Detalle de Evento'),
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique el Detalle';
        }
        return null;
      },
    );
  }

  TextFormField campoNombre() {
    return TextFormField(
      controller: nombreEveCtrl,
      decoration: InputDecoration(
        label: Text('Nombre del Evento'),
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Indique Nombre';
        }
        return null;
      },
    );
  }
}
