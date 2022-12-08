import 'package:cloud_firestore/cloud_firestore.dart';

class FirestroreService {
  Stream<QuerySnapshot> noticias() {
    return FirebaseFirestore.instance.collection('noticiaId').snapshots();
  }

  Future agregarNoticia(String titulo, String detalle) {
    return FirebaseFirestore.instance.collection('noticiaId').doc().set({
      'tituloNoticia': titulo,
      'detalleNoticia': detalle,
    });
  }

  // Future borrarNoticia(String noticiaId) {
  //   return FirebaseFirestore.instance
  //       .collection('noticias')
  //       .doc(noticiaId)
  //       .delete();
  // }
}
