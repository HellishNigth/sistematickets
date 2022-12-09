import 'dart:ui';

import 'package:cliente_tickets/pages/admin/estado_editar_page.dart';
import 'package:cliente_tickets/pages/admin/eventos_editar_page.dart';
import 'package:cliente_tickets/providers/eventos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home_admin_page.dart';

enum Actions { eliminar, editar, editarEstado }

class ListarEventosPage extends StatefulWidget {
  const ListarEventosPage({key});

  @override
  State<ListarEventosPage> createState() => _ListarEventosPageState();
}

class _ListarEventosPageState extends State<ListarEventosPage> {
  final fPrecio =
      NumberFormat.currency(decimalDigits: 0, locale: 'es-CL', symbol: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Listar Eventos',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: EventosProvider().getEventos(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              thickness: 1.3,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var evento = snapshot.data[index];

              //         MaterialPageRoute route = MaterialPageRoute(
              //           builder: (context) =>
              //               EstadoEditarPage(evento['id'].toString()),
              //         );
              //         Navigator.push(context, route).then((valor) {
              //           setState(() {});
              //
              return Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: const ValueKey(0),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {}),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        icon: Icons.save,
                        label: 'Editar Estado',
                      ),
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Color.fromARGB(255, 255, 34, 203),
                        foregroundColor: Colors.white,
                        icon: Icons.save,
                        label: 'Editar Evento',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          confirmDialog(context, evento['nombreEve'])
                              .then((confirma) {
                            if (confirma) {
                              // borrar
                              EventosProvider()
                                  .borrarEvento(evento['id'])
                                  .then((fueBorrado) {
                                if (fueBorrado) {
                                  snapshot.data.removeAt(index);
                                  setState(() {});
                                  // mostrarSnackbar(
                                  //     'Evento  ${evento['nombreEve']} borrado');
                                }
                              });
                            }
                          });
                        },
                        backgroundColor: Colors.red,
                        icon: MdiIcons.trashCan,
                        label: 'Borrar',
                      ),
                    ],
                  ),

                  // The child of the Slidable is what the user sees when the
                  // component is not dragged.
                  child: ListTile(
                    leading: Text(
                      evento['nombreEve'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      evento['detalleEve'],
                      style: TextStyle(fontSize: 13),
                    ),
                    subtitle: Text(
                      '\$' + fPrecio.format(evento['precioEve']),
                    ),
                    trailing: Text(evento['ubicacionEve']),
                    onLongPress: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EstadoEditarPage(evento['id'].toString())));
                    },
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) =>
                            EventosEditarPage(evento['id'].toString()),
                      );
                      Navigator.push(context, route).then((valor) {
                        setState(() {});
                      });
                    },
                  ));
            },
          );
        },
      ),
    );
  }
}

// void mostrarSnackbar(String mensaje) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       duration: Duration(seconds: 2),
//       content: Text(mensaje),
//     ),
//   );
// }

void doNothing(BuildContext context) {}

Future<dynamic> confirmDialog(BuildContext context, String producto) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirmación de borrado'),
        content: Text('¿Confirma borrar el evento?'),
        actions: [
          TextButton(
            child: Text('CANCELAR'),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: Text('CONFIRMAR'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );
}
