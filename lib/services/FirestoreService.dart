import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clube/services/AuthService.dart';
import 'package:diacritic/diacritic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = AuthService();
  final FirebaseAuth _auth =  FirebaseAuth.instance;


  // Constantes para horário de funcionamento
  static const int _horaAbertura = 7; // 7:00
  static const int _horaFechamento = 22; // 22:00

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

  Future<void> createQuadra(String nome,bool status, int capacidade,String tipoQuadraId )async {
    try{
      final quadraDoc = _firestore.collection('quadras').doc();
      String nomeNormalizado = removeDiacritics(nome.trim().toLowerCase());
      await quadraDoc.set({
        'nomeNormalizado':nomeNormalizado,
        'nome':nome,
        'capacidade': capacidade,
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
        'id': tipoDoc.id,
        'status': true
      });
    }catch(e){
      throw Exception(e);
    }
  }
  Future<bool> isNomeDisponivel(String idTipo, String nome) async {
    final nomeNormalizado = removeDiacritics(nome.trim().toLowerCase());

    final query = await _firestore.collection('quadras')
        .where('tipoQuadraId', isEqualTo: idTipo)
        .where('nomeNormalizado', isEqualTo: nomeNormalizado)
        .get();

    return query.docs.isEmpty;
  }

  Future<bool> getNomeDisponivel(String idTipo, String nome) async {
    QuerySnapshot snapshot = await _firestore.collection('quadras')
        .where('tipoQuadraId', isEqualTo: idTipo)
        .where('nome', isEqualTo: nome)
        .get();
    return snapshot.size==0;
  }

  Stream<QuerySnapshot> getAllTipoQuadra() {
    return _firestore.collection('tipoQuadra')
        .orderBy('nome')
        .where('status',isEqualTo: true)
        .where('id', isNotEqualTo: 'vzyWsuwL9JZIkEdT2zRP')
        .snapshots();
  }
  Stream<QuerySnapshot> getAllTipoQuadra2() {
    return _firestore.collection('tipoQuadra')
        .orderBy('nome')
        .where('status',isEqualTo: true)
        .snapshots();
  }
  
  Future<String> getTipoQuadra(String id)async {
    final doc = await _firestore.collection('tipoQuadra').doc(id).get();
    return doc.get('nome');
  }

  Future<Map<String, String>> getAllTipoQuadraMap() async {
    // QuerySnapshot snapshot = await _firestore
    //     //     .collection('tipoQuadra')
    //     //     .get();
    QuerySnapshot snapshot = await _firestore.collection('tipoQuadra')
        .orderBy('nome')
        .where('status',isEqualTo: true)
        .where('id', isNotEqualTo: 'vzyWsuwL9JZIkEdT2zRP')
        .get();

    Map<String, String> tipos = {};
    for (var doc in snapshot.docs) {
      tipos[doc.id] = doc['nome'];
    }
    return tipos;
  }

  Stream<QuerySnapshot> getQuadras() {
    return _firestore
        .collection('quadras')
        .snapshots();
  }


  Future<String> getQuadraNome(String quadraId) async {
    final doc = await _firestore.collection('quadras').doc(quadraId).get();
    return doc.get('nome') as String;
  }
  Future<void> deleteTipoQuadra(String id) async{
    final query = await _firestore
        .collection('quadras')
        .where('tipoQuadraId', isEqualTo: id)
        .get();
    for (var doc in query.docs) {
      await doc.reference.update({
        'tipoQuadraId': 'vzyWsuwL9JZIkEdT2zRP',
        'status':false
      });
    }
    final doc = await _firestore.collection('tipoQuadra').doc(id).get();
    final bool status = doc.get('status');
    await _firestore.collection('tipoQuadra').doc(id).update({'status':!status});
  }
  Future<void> editQuadra(Map<String, dynamic> updates, String id) async{
    await _firestore.collection('quadras').doc(id).update(updates);
  }
  Future<void> editTipoQuadra(Map<String, dynamic> updates, String id) async{
    await _firestore.collection('tipoQuadra').doc(id).update(updates);
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
      //encerrar a sessão secundaria e apagar o app secundario
      await secondaryAuth.signOut();
      await secondaryApp.delete();
    } on FirebaseAuthException catch (e){
      String error;
      switch(e.code){
        case 'email-already-in-use':
          error = 'Este email já está em uso. Tente outro.';
          break;
        case 'weak-password':
          error = 'A senha é muito fraca. Utilize pelo menos 6 caracteres.';
          break;
        case 'invalid-email':
          error = 'O e-mail fornecido não é válido.';
          break;
        case 'network-request-failed':
          error = 'Falha na conexão com a internet. Tente novamente.';
          break;
        default:
          error = 'Erro desconhecido. Tente novamente mais tarde.';
          break;
      }
      throw error;
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

  // Método para validar horário de funcionamento
  bool _isHorarioFuncionamento(DateTime dataHora) {
    final hora = dataHora.hour;
    return hora >= _horaAbertura && hora < _horaFechamento;
  }

  // Método para contar quadras ocupadas no horário
  Future<int> _contarQuadrasOcupadas(String tipoQuadraId, DateTime dataHora) async {
    final inicioSlot = dataHora;
    final fimSlot = dataHora.add(Duration(hours: 1));
    
    final reservas = await _firestore
        .collection('reservas')
        .where('tipoQuadraId', isEqualTo: tipoQuadraId)
        .where('dataHora', isGreaterThanOrEqualTo: Timestamp.fromDate(inicioSlot))
        .where('dataHora', isLessThan: Timestamp.fromDate(fimSlot))
        .where('status', isEqualTo: true)
        .get();
    
    return reservas.docs.length;
  }

  // Método para contar total de quadras disponíveis do tipo
  Future<int> _contarQuadrasDisponiveis(String tipoQuadraId) async {
    final quadras = await _firestore
        .collection('quadras')
        .where('tipoQuadraId', isEqualTo: tipoQuadraId)
        .where('status', isEqualTo: true)
        .get();
    
    return quadras.docs.length;
  }

  

  Future<void> createReserva({
    required String tipoQuadraId,
    required DateTime dataHora,
  }) async {
    final uid = auth.getCurrentUser();
    final agora = DateTime.now();

    // Validar se a hora é em ponto (minutos = 0)
    if (dataHora.minute != 0) {
      throw Exception('Reservas só podem ser feitas em horários fechados (exemplo: 08:00, 09:00, etc.).');
    }

    // Validar horário de funcionamento
    if (!_isHorarioFuncionamento(dataHora)) {
      throw Exception('Reservas só podem ser feitas das $_horaAbertura:00 às $_horaFechamento:00.');
    }

    // RN5: não reservar para horário passado
    if (dataHora.isBefore(agora)) {
      throw Exception('Não é possível reservar para horário já passado.');
    }

    // RN4: verificar reserva do mesmo sócio no mesmo dia e tipo
    final inicioDia = DateTime(dataHora.year, dataHora.month, dataHora.day);
    final fimDia = inicioDia.add(Duration(days: 1));
    final reservasCliente = await _firestore
        .collection('reservas')
        .where('idMembro', isEqualTo: uid)
        .where('tipoQuadraId', isEqualTo: tipoQuadraId)
        .where('dataHora', isGreaterThanOrEqualTo: Timestamp.fromDate(inicioDia))
        .where('dataHora', isLessThan: Timestamp.fromDate(fimDia))
        .where('status', isEqualTo: true)
        .get();

    if (reservasCliente.docs.isNotEmpty) {
      final tipoNome = await getTipoQuadra(tipoQuadraId);
      throw Exception('Você já possui uma reserva de $tipoNome para este dia.');
    }

    // Verificar se há quadras disponíveis neste horário
    final quadrasOcupadas = await _contarQuadrasOcupadas(tipoQuadraId, dataHora);
    final totalQuadras = await _contarQuadrasDisponiveis(tipoQuadraId);

    if (quadrasOcupadas >= totalQuadras) {
      final tipoNome = await getTipoQuadra(tipoQuadraId);
      throw Exception('Não há quadras de $tipoNome disponíveis neste horário.');
    }

    // RN1: buscar quadras disponíveis (status=true e sem reserva no horário)
    final quadras = await _firestore
        .collection('quadras')
        .where('tipoQuadraId', isEqualTo: tipoQuadraId)
        .where('status', isEqualTo: true)
        .get();

    for (var q in quadras.docs) {
      final idQuadra = q.id;
      // verificar se há reserva neste horário exato
      final inicioSlot = dataHora;
      final fimSlot = dataHora.add(Duration(hours: 1)); // RN3
      final conflito = await _firestore
          .collection('reservas')
          .where('idQuadra', isEqualTo: idQuadra)
          .where('dataHora', isGreaterThanOrEqualTo: Timestamp.fromDate(inicioSlot))
          .where('dataHora', isLessThan: Timestamp.fromDate(fimSlot))
          .where('status', isEqualTo: true)
          .get();
      if (conflito.docs.isEmpty) {
        // quadra livre, cria reserva
        final doc = _firestore.collection('reservas').doc();
        await doc.set({
          'id': doc.id,
          'idMembro': uid,
          'tipoQuadraId': tipoQuadraId,
          'idQuadra': idQuadra,
          'dataHora': Timestamp.fromDate(dataHora),
          'status': true,
        });
        return;
      }
    }

    final tipoNome = await getTipoQuadra(tipoQuadraId);
    throw Exception('Não há quadras de $tipoNome disponíveis neste horário.');
  }

   /// Lista reservas do usuário autenticado
  Stream<QuerySnapshot> getReservasDoUsuario(String userId) {
    return _firestore
        .collection('reservas')
        .where('idMembro', isEqualTo: userId)
        .orderBy('status',descending: true)
        .orderBy('dataHora')
        .snapshots();
  }

  Stream<QuerySnapshot> getReservasDoUsuarioHoje(String userId) {
    final now = DateTime.now();
    final inicioDia = DateTime(now.year, now.month, now.day);
    final fimDia = inicioDia.add(Duration(days: 1));
    return _firestore
        .collection('reservas')
        .where('idMembro', isEqualTo: userId)
        .where('dataHora', isGreaterThanOrEqualTo: Timestamp.fromDate(inicioDia))
        .where('dataHora', isLessThan: Timestamp.fromDate(fimDia))
        .orderBy('dataHora')
        .snapshots();
  }


  Future<void> cancelarReserva(String id) async {
  await FirebaseFirestore.instance.collection('reservas').doc(id).update({'status': false});
}
  Future<void> updateReserva(String id, Map<String, dynamic> dados) async {
  await FirebaseFirestore.instance.collection('reservas').doc(id).update(dados);
}
}