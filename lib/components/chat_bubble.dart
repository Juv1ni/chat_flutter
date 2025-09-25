import 'package:chat_flutter/themes/theme_provider.dart'; // Importa o provider responsável pelo tema (claro/escuro)
import 'package:flutter/material.dart'; // Biblioteca principal do Flutter (widgets, estilos, etc.)
import 'package:provider/provider.dart'; // Pacote para gerenciar estados e dependências (Provider)

// Widget que representa uma "bolha de chat"
class ChatBubble extends StatelessWidget {
  final String message; // Texto da mensagem
  final bool
  isCurrentUser; // Define se a mensagem foi enviada pelo usuário atual

  // Construtor da classe
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    // Verifica se o app está no modo escuro usando o ThemeProvider
    bool isDarkMode = Provider.of<ThemeProvider>(
      context,
      listen:
          false, // listen: false -> não reconstrói o widget quando o tema mudar
    ).isDarkMode;

    return Container(
      // Caixa que envolve a mensagem
      decoration: BoxDecoration(
        // Define a cor da bolha de acordo com o usuário e tema
        color: isCurrentUser
            ? (isDarkMode
                  ? Colors.green.shade600
                  : Colors.green.shade500) // Se for o usuário: verde
            : (isDarkMode
                  ? Colors.grey.shade800
                  : Colors.grey.shade200), // Se for outra pessoa: cinza
        borderRadius: BorderRadius.circular(12), // Bordas arredondadas
      ),
      padding: const EdgeInsets.all(16), // Espaçamento interno
      margin: const EdgeInsets.symmetric(
        vertical: 2.5,
        horizontal: 25,
      ), // Espaçamento externo
      child: Text(
        message, // Texto da mensagem
        style: TextStyle(
          // Cor do texto depende do tema e de quem enviou
          color: isCurrentUser
              ? Colors
                    .white // Se for o usuário -> branco
              : (isDarkMode
                    ? Colors.white
                    : Colors
                          .black), // Senão: branco no dark mode, preto no light mode
        ),
      ),
    );
  }
}
