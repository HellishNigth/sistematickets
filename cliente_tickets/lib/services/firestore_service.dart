import 'package:cloud_firestore/cloud_firestore.dart';

class FirestroreService{
  Stream<QuerySnapshot> noticias(){
    return FirebaseFirestore.instance.collection('noticias').snapshots();
  }

  Future agregarNoticia(String titulo ,String detalle) {
    return FirebaseFirestore.instance.collection('noticias').doc().set({
      'tituloNoticia': titulo,
      'detalleNoticia': detalle,
    });
  }

  Future borrarNoticia(String noticiaId) {
    return FirebaseFirestore.instance.collection('noticias').doc(noticiaId).delete();
  } 
}