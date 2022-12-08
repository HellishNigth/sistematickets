import 'dart:ui';

import 'package:cliente_tickets/pages/admin/eventos_editar_page.dart';
import 'package:cliente_tickets/providers/eventos_provider.dart';
import 'package:flutter/material.dart';
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
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(MdiIcons.trashCan, color: Colors.white),
                        Text(
                          'Borrar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
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
                        builder: (context) => EventosEditarPage(evento['id']),
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
