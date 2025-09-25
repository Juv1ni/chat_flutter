import 'package:chat_flutter/pages/home_page.dart';
import 'package:chat_flutter/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Widget que decide qual tela exibir com base no estado de autenticação
/// Se o usuário estiver logado → HomePage
/// Se não estiver logado → LoginOrRegister
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // StreamBuilder observa as mudanças no estado de autenticação do Firebase
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Se houver usuário logado
          if (snapshot.hasData) {
            return HomePage(); // mostra a tela inicial do app
          } else {
            // Se não estiver logado
            return const LoginOrRegister(); // mostra tela de login/registro
          }
        },
      ),
    );
  }
}
