import 'package:chat_flutter/components/my_button.dart';
import 'package:chat_flutter/components/my_textfield.dart';
import 'package:chat_flutter/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final void Function()? onTap;

  LoginPage({
    super.key,
    required this.onTap,
    });

  void login(BuildContext context) async {
    final authService = AuthService();

    try{
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text,);
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
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
                "Bem-vindo(a) de volta, sentimos sua falta!",
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
          
              const SizedBox(height: 25,),
          
              MyButton(
                text: "Login",
                onTap: () => login(context),
              ),
          
              const SizedBox(height: 25,),
          
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
                    onTap: onTap,
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