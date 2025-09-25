import 'package:flutter/material.dart'; // Biblioteca principal do Flutter para widgets e estilos

// Widget personalizado para criar um botão reaproveitável
class MyButton extends StatelessWidget {
  final void Function()?
  onTap; // Função que será executada quando o botão for clicado
  final String text; // Texto exibido dentro do botão

  // Construtor da classe
  const MyButton({
    super.key,
    required this.text, // Define o texto do botão como obrigatório
    required this.onTap, // Define a ação do botão como obrigatória
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Detecta o clique e chama a função recebida
      child: Container(
        // Caixa que representa o botão
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.secondary, // Cor do botão (pegando do tema do app)
          borderRadius: BorderRadius.circular(8), // Bordas arredondadas
        ),
        padding: const EdgeInsets.all(
          25,
        ), // Espaçamento interno (tamanho do botão)
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
        ), // Espaçamento externo (dos lados)
        child: Center(
          child: Text(
            text, // Texto que aparece dentro do botão
          ),
        ),
      ),
    );
  }
}
