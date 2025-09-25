import 'package:chat_flutter/components/my_drawer.dart';
import 'package:chat_flutter/components/user_tile.dart';
import 'package:chat_flutter/pages/chat_page.dart';
import 'package:chat_flutter/services/auth/auth_service.dart';
import 'package:chat_flutter/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

/// Página principal do app (depois de logado)
/// Mostra a lista de usuários disponíveis para conversar
class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Instância do serviço de chat (para buscar usuários e mensagens)
  final ChatServices _chatService = ChatServices();

  // Instância do serviço de autenticação (para pegar info do usuário logado)
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // Barra de navegação superior
      appBar: AppBar(
        title: Text("Início"),
        backgroundColor: Colors.transparent, // sem fundo
        foregroundColor: Colors.grey, // cor do texto e ícones
        elevation: 0, // sem sombra
      ),

      // Menu lateral (Drawer personalizado)
      drawer: const MyDrawer(),

      // Corpo da tela: lista de usuários
      body: _buildUserList(),
    );
  }

  /// Constrói a lista de usuários em tempo real
  Widget _buildUserList() {
    return StreamBuilder(
      // Stream de usuários vinda do Firestore (via ChatServices)
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Caso dê erro ao carregar
        if (snapshot.hasError) {
          return const Text("Erro");
        }

        // Enquanto os dados estão carregando
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregando...");
        }

        // Quando já tem dados, cria uma lista de tiles (usuários)
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  /// Constrói cada item da lista de usuários
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    // Não mostra o próprio usuário logado na lista
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"], // exibe o email do usuário
        onTap: () {
          // Ao clicar no usuário, abre a tela de chat com ele
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      // Se for o próprio usuário logado, retorna um container vazio
      return Container();
    }
  }
}
