// ignore_for_file: no_leading_underscores_for_local_identifiers
// Ignore warnings sobre nomes de variáveis privadas locais com underscore

import 'package:chat_flutter/components/my_button.dart';
import 'package:chat_flutter/components/my_textfield.dart';
import 'package:chat_flutter/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

/// Tela de Registro de usuário
/// Permite criar uma nova conta com email e senha
class RegisterPage extends StatelessWidget {
  // Controladores para os campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  // Controlador para confirmar senha
  final TextEditingController _ConfirmPwController = TextEditingController();

  // Função callback (usada para voltar para a tela de login)
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  /// Função que registra o usuário
  void registrar(BuildContext context) {
    final _auth = AuthService();

    // Verifica se as senhas digitadas são iguais
    if (_pwController.text == _ConfirmPwController.text) {
      try {
        // Tenta criar a conta usando email e senha
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        // Se ocorrer algum erro no registro, mostra um alerta
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    } else {
      // Se as senhas não conferem, mostra alerta
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: const Text("As senhas não são coincidem!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // Centraliza o conteúdo
      body: Center(
        child: SingleChildScrollView(
          // Permite rolar a tela em dispositivos menores
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone no topo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 50),

              // Texto de boas-vindas
              Text(
                "Vamos criar uma conta para você",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // Campo de email
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),

              const SizedBox(height: 10),

              // Campo de senha
              MyTextField(
                hintText: "Senha",
                obscureText: true,
                controller: _pwController,
              ),

              const SizedBox(height: 10),

              // Campo de confirmação de senha
              MyTextField(
                hintText: "Confirmar Senha",
                obscureText: true,
                controller: _ConfirmPwController,
              ),

              const SizedBox(height: 25),

              // Botão de registrar
              MyButton(text: "Registrar", onTap: () => registrar(context)),

              const SizedBox(height: 25),

              // Link para voltar à tela de login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Já tem uma conta? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap, // Dispara a função recebida
                    child: Text(
                      "Conecte-se agora!",
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
