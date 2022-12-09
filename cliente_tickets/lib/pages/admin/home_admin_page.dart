import 'package:animate_do/animate_do.dart';
import 'package:cliente_tickets/pages/admin/agregar_eventos_page.dart';
import 'package:cliente_tickets/pages/admin/listar_eventos_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({Key? key}) : super(key: key);

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int paginaSel = 0;
  final paginas = [ListarEventosPage(), EventosAgregarPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeInDown(child: Text('Tickets For Tickets')),
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
            label: 'Agregar Evento',
          )
        ],
      ),
    );
  }
}
