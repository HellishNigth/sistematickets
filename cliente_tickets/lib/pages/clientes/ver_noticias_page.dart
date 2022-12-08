import 'package:cliente_tickets/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class VerNoticiasPage extends StatelessWidget {
  const VerNoticiasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ver Noticias'),
        ),
        body: StreamBuilder(
            stream: FirestroreService().noticias(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var noticia = snapshot.data!.docs[index];
                  return ListTile(
                    leading: Icon(
                      MdiIcons.cube,
                      color: Colors.deepPurple,
                    ),
                    title: Text(noticia['tituloNoticia']),
                    subtitle: Text('Stock:${noticia['detalleNoticia']}'),
                  );
                },
              );
            }));
  }
}
