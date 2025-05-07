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

    final userDoc = _firestore.collection('membros').doc(userId);
    await userDoc.set({
      'email': email,
      'nome': nome,
      'telefone': telefone,
      'role': role,
      'ativo': true,
    });
  }

  Future<void> createQuadra(String localizacao, bool status, int capacidade,String tipoQuadraId )async {
    try{
      final quadraDoc = _firestore.collection('quadras').doc();
      await quadraDoc.set({
        'capacidade': capacidade,
        'localizacao': localizacao,
        'status': status,
        'id': quadraDoc.id,
        'tipoQuadraId': tipoQuadraId
      });
    }catch(e){
      throw Exception(e);
    }
  }
  Future<void> createTipoQuadra(String nome)async {
    try{
      final tipoDoc = _firestore.collection('tipoQuadra').doc();
      await tipoDoc.set({
        'nome': nome,
        'id': tipoDoc.id
      });
    }catch(e){
      throw Exception(e);
    }
  }
  Stream<QuerySnapshot> getTipoQuadra() {
    return FirebaseFirestore.instance.collection('tipoQuadra').snapshots();
  }
  Future<void> editQuadra(Map<String, dynamic> updates, String id) async{
    await _firestore.collection('quadras').doc(id).update(updates);
  }

  Future<void> setStatusQuadra(String id) async{
    bool status = await getStatusQuadra(id);
    await _firestore.collection('quadras').doc(id).update({'status':!status});
  }

  Future<bool> getStatusQuadra(String id) async{
    final DocumentSnapshot quadraDoc =
    await _firestore.collection('quadras').doc(id).get();
    return quadraDoc.get('status');
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
      await FirebaseFirestore.instance.collection('membros').doc(membroUid).set({
        'nome': nome,
        'email': email,
        'telefone': telefone,
        'tipo': tipo,
        'idAdministrador': adminUid,
        'ativo': true,
        'criadoEm': Timestamp.now(),
      });
      print('Membro cadastrado com sucesso!');
      //encerrar a sessão secundaria e apagar o app secundario
      await secondaryAuth.signOut();
      await secondaryApp.delete();
    } catch (e) {
      throw Exception('Erro ao criar membro: $e');
    }
  }
    Future<String> getTipo() async {
      final userId = auth.getCurrentUser();
      final DocumentSnapshot userDoc =
      await _firestore.collection('membros').doc(userId).get();
      return userDoc.get('tipo').toString();
    }

    Future<String> getData(String collection,String id,String field) async {
      final DocumentSnapshot userDoc =
      await _firestore.collection(collection).doc(id).get();
      return userDoc.get(field).toString();
    }

    Future<String> getUserField(String field) async {
      final userId = auth.getCurrentUser();
      final DocumentSnapshot userDoc =
      await _firestore.collection('membros').doc(userId).get();
      return userDoc.get(field).toString();
    }

    Future<Map<String, dynamic>> getUserData()async{
      final userId = auth.getCurrentUser();
      final doc = await _firestore.collection('membros').doc(userId).get();
      return doc.data()!;
    }

    Future<void> updateProfile(Map<String, dynamic> updates) async {
      final userId = auth.getCurrentUser();
      await _firestore.collection('membros').doc(userId).update(updates);
    }
  Future<void> updateUserProfile(Map<String, dynamic> updates, String id) async {
    final userId = id;
    await _firestore.collection('membros').doc(userId).update(updates);
  }

  //Listar todos os membros 
  Stream<QuerySnapshot> getMembrosStream() {
    return _firestore.collection('membros').snapshots();
  }
  //Listar de membros associado ao administrador
  Stream<QuerySnapshot> getMembrosDoAdmin(String adminUid) {
  return _firestore
      .collection('membros')
      .where('idAdministrador', isEqualTo: adminUid)
      .where('ativo', isEqualTo: true)
      .snapshots();
}
  Stream<QuerySnapshot> getMembrosAtivos() {
    return _firestore
        .collection('membros')
        .where('ativo', isEqualTo: true)
        .where("tipo",isEqualTo: "Membro")
        .orderBy("nome")
        .snapshots();
  }
  //deletar membro
    Future<void> deletarMembro(String id) async {
    await _firestore.collection('membros').doc(id).delete();
  }

  // Se quiser atualizar membro:
  Future<void> atualizarMembro(String id, Map<String, dynamic> data) async {
    await _firestore.collection('membros').doc(id).update(data);
  }
}