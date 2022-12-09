import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TileDetalleEvento extends StatelessWidget {
  const TileDetalleEvento({
    Key? key,
    required this.evento,
  }) : super(key: key);

  final evento;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        MdiIcons.cube,
        color: Colors.amber,
      ),
      title: Text(evento['nombreEve']),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            evento['detalleEve']
          ),
        ],
      ),
    );
  }
}