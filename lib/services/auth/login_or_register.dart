import 'package:chat_flutter/pages/login_page.dart';
import 'package:chat_flutter/pages/register_page.dart';
import 'package:flutter/material.dart';

/// Widget que alterna entre LoginPage e RegisterPage
/// Controla o fluxo de autenticação do usuário
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Controla se deve mostrar a tela de login (true) ou registro (false)
  bool showLoginPage = true;

  /// Alterna entre as telas de login e registro
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Se showLoginPage for true → mostra LoginPage
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages, // callback para alternar para registro
      );
    } else {
      // Se showLoginPage for false → mostra RegisterPage
      return RegisterPage(
        onTap: togglePages, // callback para alternar para login
      );
    }
  }
}
