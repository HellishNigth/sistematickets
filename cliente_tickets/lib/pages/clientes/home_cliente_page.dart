import 'package:cliente_tickets/pages/clientes/nav_contents/eventos_page.dart';
import 'package:cliente_tickets/pages/clientes/nav_contents/mi_tickets_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeClientePage extends StatefulWidget {
  const HomeClientePage({Key? key}) : super(key: key);

  @override
  State<HomeClientePage> createState() => _HomeClientePageState();
}

class _HomeClientePageState extends State<HomeClientePage> {
  int paginaSel = 0;
  final paginas = [MiTicketsPage(), EventosClientesPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets For Tickets'),
      ),
      body: paginas[paginaSel],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: paginaSel,
        onTap: (index) {
          setState(() {
            paginaSel = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.cube),
            label: 'Eventos',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.cube),
            label: 'Mis Tickets',
          )
        ],
      ),
    );
  }
}
