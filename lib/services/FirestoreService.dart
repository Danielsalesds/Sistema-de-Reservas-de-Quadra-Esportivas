import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clube/services/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final auth = AuthService();
  Future<void> createUser(String nome, String email, String telefone, String role)async{
    final userId = auth.getCurrentUser();
    final user = _firestore.collection('usuarios').doc(userId);
    await user.set({
      'email': email,
      'nome': nome,
      'telefone': telefone,
      'role': role
    }).then((_) {
      print("Cadastro criado com sucesso!");
    }).catchError((error) {
      print("Falha ao criar cadastro: $error");
    });
  }

  Future<String> getRole() async {
    final userId = auth.getCurrentUser();
    final DocumentSnapshot userDoc =
    await _firestore.collection('usuarios').doc(userId).get();
    return userDoc.get('role').toString();
  }

  Future<String> getData(String field) async {
    final userId = auth.getCurrentUser();
    final DocumentSnapshot userDoc =
    await _firestore.collection('usuarios').doc(userId).get();
    return userDoc.get(field).toString();
  }

  Future<void> updateProfile(Map<String, dynamic> updates)async{
    final userId = auth.getCurrentUser();
    await _firestore.collection('usuarios').doc(userId).update(updates);
  }
}