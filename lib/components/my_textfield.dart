import 'package:flutter/material.dart'; // Biblioteca principal do Flutter

// Campo de texto personalizado
class MyTextField extends StatelessWidget {
  final String hintText; // Texto de dica (placeholder dentro do campo)
  final bool obscureText; // Define se o texto será oculto (ex.: senha)
  final TextEditingController
  controller; // Controlador para manipular o valor do campo
  final FocusNode? focusNode; // Permite controlar o foco do campo (opcional)

  // Construtor do widget
  const MyTextField({
    super.key,
    required this.hintText, // Obrigatório: o placeholder
    required this.obscureText, // Obrigatório: define se o campo é senha
    required this.controller, // Obrigatório: controller do campo
    this.focusNode, // Opcional: foco
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ), // Espaçamento lateral
      child: TextField(
        obscureText: obscureText, // Oculta o texto se for senha
        controller: controller, // Liga o campo ao controlador
        focusNode: focusNode, // Define o foco se fornecido
        decoration: InputDecoration(
          // Borda quando o campo NÃO está focado
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.tertiary, // Cor do tema (terciária)
            ),
          ),
          // Borda quando o campo ESTÁ focado
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.primary, // Cor do tema (primária)
            ),
          ),
          fillColor: Theme.of(
            context,
          ).colorScheme.secondary, // Cor de fundo do campo
          filled: true, // Ativa o preenchimento do fundo
          hintText: hintText, // Placeholder dentro do campo
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary, // Cor do placeholder
          ),
        ),
      ),
    );
  }
}
