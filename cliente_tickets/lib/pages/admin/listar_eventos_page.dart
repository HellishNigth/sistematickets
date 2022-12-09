import 'dart:ui';

import 'package:cliente_tickets/pages/admin/estado_editar_page.dart';
import 'package:cliente_tickets/pages/admin/eventos_editar_page.dart';
import 'package:cliente_tickets/providers/eventos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
              return Dismissible(
                  key: ObjectKey(evento),
                  background: Container(
                    color: Colors.purple,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(MdiIcons.noteEdit, color: Colors.white),
                        Text(
                          'Editar Estado',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(MdiIcons.trashCan, color: Colors.white),
                        Text(
                          'Borrar Evento',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  // direction: DismissDirection.endToStart,
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      EventosProvider()
                          .borrarEvento(evento['id'].toString())
                          .then((fueBorrado) {
                        if (fueBorrado) {
                          snapshot.data.removeAt(index);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text('Evento borrado'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text('No se pudo borrar'),
                            ),
                          );
                        }
                      });
                    } else {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) =>
                            EstadoEditarPage(evento['id'].toString()),
                      );
                      Navigator.push(context, route).then((valor) {
                        setState(() {});
                      });
                    }
                  },
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

void doNothing(BuildContext context) {}
