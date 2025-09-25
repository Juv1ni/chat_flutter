import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Serviço de autenticação do app
/// Faz login, registro e logout usando FirebaseAuth
/// Também salva informações do usuário no Firestore
class AuthService {
  // Instância do FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Instância do Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Retorna o usuário logado atualmente (ou null se não tiver)
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Faz login com email e senha
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      // Tenta autenticar o usuário
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Garante que o usuário esteja registrado no Firestore
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Lança exceção com o código de erro do Firebase
      throw Exception(e.code);
    }
  }

  /// Registra um novo usuário com email e senha
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      // Cria o usuário no Firebase Auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Salva informações básicas do usuário no Firestore
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Lança exceção com o código de erro
      throw Exception(e.code);
    }
  }

  /// Faz logout do usuário atual
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
