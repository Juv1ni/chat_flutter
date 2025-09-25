import 'package:flutter/material.dart'; // Biblioteca principal do Flutter

// Widget que representa um "tile" (caixinha) de usuário
class UserTile extends StatelessWidget {
  final String text; // Nome ou informação do usuário que vai aparecer
  final void Function()?
  onTap; // Ação quando o tile for clicado (ex.: abrir chat)

  const UserTile({
    super.key,
    required this.text, // Obrigatório: texto a ser exibido
    required this.onTap, // Obrigatório: ação de clique
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Detecta clique no tile e executa a função passada
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.secondary, // Cor de fundo (pegando do tema)
          borderRadius: BorderRadius.circular(12), // Bordas arredondadas
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 25.0,
        ), // Espaçamento externo
        padding: const EdgeInsets.all(20), // Espaçamento interno
        child: Row(
          children: [
            Icon(Icons.person), // Ícone de usuário
            const SizedBox(width: 20), // Espaço entre ícone e texto
            Text(text), // Nome do usuário
          ],
        ),
      ),
    );
  }
}
