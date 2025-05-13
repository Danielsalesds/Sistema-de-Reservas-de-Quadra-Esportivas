import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp (String email, String senha) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      return userCredential;
    }on FirebaseAuthException catch (e){
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
  Future<UserCredential> signIn(String email, String senha) async{
      return await _auth.signInWithEmailAndPassword(email: email, password: senha);
  }

  Future<void> resetPassword(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      throw Exception(e);
    }
  }
  Future<void> signOut() async{
    return await _auth.signOut();
  }

  String getCurrentUser(){
    return _auth.currentUser!.uid;
  }

  String? getCurrentUserEmail(){
    return _auth.currentUser!.email;
  }
}