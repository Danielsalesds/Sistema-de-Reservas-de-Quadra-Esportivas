import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp (String email, String senha) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      return userCredential;
    }on FirebaseAuthException catch (e){
      throw Exception(e.message);
    }
  }
  Future<UserCredential> signIn(String email, String senha) async{
    // Essa função já deve criar o cadastro do usuário no Firestore tbm.
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: senha);
      return userCredential;
    }on FirebaseAuthException catch(e){
      throw Exception(e.message);
    }
  }

  Future<void> resetPassword(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
      print("Email enviado!");
    }catch(e){
      print("Exception $e");
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