import 'package:chat_flutter/pages/settings_page.dart'; // Importa a página de configurações
import 'package:chat_flutter/services/auth/auth_service.dart'; // Importa o serviço de autenticação (logout etc.)
import 'package:flutter/material.dart'; // Biblioteca principal do Flutter

// Drawer personalizado (menu lateral do app)
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Função de logout
  void logout() {
    final auth = AuthService(); // Cria uma instância do serviço de autenticação
    auth.signOut(); // Faz logout do usuário
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(
        context,
      ).colorScheme.surface, // Cor do fundo do Drawer
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Espaça o conteúdo: parte de cima e parte de baixo
        children: [
          // Parte de cima do Drawer (logo + opções principais)
          Column(
            children: [
              // Cabeçalho do Drawer (ícone da aplicação)
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary, // Usa a cor primária do tema
                    size: 40,
                  ),
                ),
              ),

              // Opção "Início"
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("Início"),
                  leading: const Icon(Icons.home), // Ícone da opção
                  onTap: () {
                    Navigator.pop(context); // Fecha o Drawer
                  },
                ),
              ),

              // Opção "Configurações"
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("Configurações"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context); // Fecha o Drawer antes de navegar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SettingsPage(), // Abre a página de configurações
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Parte de baixo do Drawer (logout)
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: const Text("Deslogar"),
              leading: const Icon(Icons.logout),
              onTap: logout, // Chama a função de logout
            ),
          ),
        ],
      ),
    );
  }
}
