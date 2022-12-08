import 'package:cliente_tickets/providers/eventos_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MiTicketsPage extends StatelessWidget {
  const MiTicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return ListTile(
                leading: Icon(MdiIcons.stadium),
                title: Text(evento['nombreEve']),
                subtitle: Text('Ubicacion: ${evento['fechaEve']}'),
                trailing: Text('Fecha: ${evento['fechaEve']}'),
              );
            },
          );
        },
      ),
    );
  }
}
