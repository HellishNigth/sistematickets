import 'package:cliente_tickets/providers/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AgregarTicketsPage extends StatefulWidget {
  const AgregarTicketsPage({Key? key}) : super(key: key);

  @override
  State<AgregarTicketsPage> createState() => _AgregarTicketsPageState();
}

class _AgregarTicketsPageState extends State<AgregarTicketsPage> {
  final fPrecio =
      NumberFormat.currency(decimalDigits: 0, locale: 'es-CL', symbol: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets'),
      ),
      body: FutureBuilder(
        future: TicketsProvider().getTickets(),
        builder: (context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
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
              var ticket = snapshot.data[index];
              String cantTicket = ticket['evento'] == null? 'Sin Categoría': ticket['evento']['cantidadTicket'];
              return Slidable(
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Colors.purple,
                      icon: Icons.file_open,
                      label: 'Agregar',
                    )
                  ],
                ),
                child: ListTile(
                  leading: Icon(MdiIcons.cube),
                  title: Text('(${cantTicket}) ${ticket['CantidadTicket']}'),
                  subtitle: Text('Stock: ${ticket['stock']}'),
                  trailing: Text(
                    '\$' + fPrecio.format(ticket['totalTicket']),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => AgregarTicketsPage(),
          );
          Navigator.push(context, route).then((value) {
            setState(() {});
          });
        },
      )
    );
  }
}