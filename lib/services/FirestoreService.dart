import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clube/services/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = AuthService();
  final FirebaseAuth _auth =  FirebaseAuth.instance;

  Future<void> createUser(
    String nome,
    String email,
    String telefone,
    String role
  ) async {
    final userId =  _auth.currentUser?.uid; // <- Pega o UID do usuário autenticado

    if (userId == null) {
      throw Exception("Usuário não autenticado!");
    }

    final userDoc = _firestore.collection('usuarios').doc(userId);
    await userDoc.set({
      'email': email,
      'nome': nome,
      'telefone': telefone,
      'role': role,
    });
  }

  Future<void> createMembro (String nome, String email, String telefone, String tipo, String senha ) async {
    try {
      final admin = FirebaseAuth.instance.currentUser;

      if (admin == null) {
        print("Admin não logado!");
        return;
      }
      final adminUid = admin.uid;

      //  Cria uma instância FirebaseApp secundária temporária
      final FirebaseApp secondaryApp = await Firebase.initializeApp(
        name: 'SecondaryApp',
        options: Firebase
            .app()
            .options,
      );
      //  Usa FirebaseAuth da instância secundária
      final FirebaseAuth secondaryAuth = FirebaseAuth.instanceFor(
          app: secondaryApp);
      //  Cria o usuário (membro) sem afetar a sessão do admin
      final UserCredential userCredential = await secondaryAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      final user = userCredential.user;
      if (user == null) {
        print("Erro ao obter usuário criado.");
        return;
      }
      final membroUid = user.uid;
      // Salva os dados do membro no Firestore (usando app padrão)
      await FirebaseFirestore.instance.collection('membros').doc(membroUid).set(
          {
            'nome': nome,
            'email': email,
            'telefone': telefone,
            'tipo': tipo,
            'idAdministrador': adminUid,
            'criadoEm': Timestamp.now(),
          });
      print('Membro cadastrado com sucesso!');
      //encerrar a sessão secundaria e apagar o app secundario
      await secondaryAuth.signOut();
      await secondaryApp.delete();
    } catch (e) {
      print('Erro ao criar membro: $e');
    }
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

    Future<void> updateProfile(Map<String, dynamic> updates) async {
      final userId = auth.getCurrentUser();
      await _firestore.collection('usuarios').doc(userId).update(updates);
    }

}