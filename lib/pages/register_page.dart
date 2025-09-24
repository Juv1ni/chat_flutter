// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chat_flutter/components/my_button.dart';
import 'package:chat_flutter/components/my_textfield.dart';
import 'package:chat_flutter/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _ConfirmPwController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
    });

  void registrar(BuildContext context) {
    final _auth = AuthService();
    
    if (_pwController.text == _ConfirmPwController.text){
      try {
        _auth.signUpWithEmailPassword(_emailController.text, _pwController.text,);
      } catch (e) {
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("As senhas não são coincidem!"),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              
              const SizedBox(height: 50,),
          
              Text(
                "Vamos criar uma conta para você",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  ),
              ),
          
              const SizedBox(height: 25,),
          
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),
          
              const SizedBox(height: 10,),
          
              MyTextField(
                hintText: "Senha",
                obscureText: true,
                controller: _pwController,
              ),
          
              const SizedBox(height: 10,),
          
              MyTextField(
                hintText: "Confirmar Senha",
                obscureText: true,
                controller: _ConfirmPwController,
              ),
          
              const SizedBox(height: 25,),
          
              MyButton(
                text: "Registrar",
                onTap: () => registrar(context),
              ),
          
              const SizedBox(height: 25,),
          
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
                    onTap: onTap,
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