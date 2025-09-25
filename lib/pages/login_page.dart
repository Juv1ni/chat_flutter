import 'package:chat_flutter/components/my_button.dart';
import 'package:chat_flutter/components/my_textfield.dart';
import 'package:chat_flutter/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

/// Tela de Login
/// Permite que o usuário insira email e senha, faça login,
/// e também navegue para a tela de registro
class LoginPage extends StatelessWidget {
  // Controladores para os campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // Função callback (usada para ir para a tela de registro)
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  /// Função que realiza o login
  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      // Tenta fazer login com email e senha
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
    } catch (e) {
      // Caso dê erro, mostra um diálogo com a mensagem
      showDialog(
        // ignore: use_build_context_synchronously → ignora aviso do Flutter
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // Centraliza tudo na tela
      body: Center(
        child: SingleChildScrollView(
          // permite rolar em telas pequenas
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone de mensagem no topo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 50),

              // Texto de boas-vindas
              Text(
                "Bem-vindo(a) de volta, sentimos sua falta!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // Campo para email
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),

              const SizedBox(height: 10),

              // Campo para senha
              MyTextField(
                hintText: "Senha",
                obscureText: true,
                controller: _pwController,
              ),

              const SizedBox(height: 25),

              // Botão de login
              MyButton(text: "Login", onTap: () => login(context)),

              const SizedBox(height: 25),

              // Link para a tela de registro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Não é um membro? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap, // dispara a função recebida
                    child: Text(
                      "Registre-se agora!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
