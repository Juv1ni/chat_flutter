import 'package:chat_flutter/themes/theme_provider.dart'; // Provider que gerencia tema do app
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Tela de Configurações
/// Permite ativar/desativar o Dark Mode
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // AppBar transparente com título
      appBar: AppBar(
        title: const Text("Configurações"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),

      // Corpo da tela
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.secondary, // cor de fundo do card
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(25), // espaço externo
        padding: const EdgeInsets.all(16), // espaço interno
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // espaço entre texto e switch
          children: [
            const Text("Dark Mode"), // texto do item
            // Switch do tipo Cupertino (iOS)
            CupertinoSwitch(
              // Valor atual do Dark Mode
              value: Provider.of<ThemeProvider>(
                context,
                listen: false, // não precisa rebuildar quando mudar
              ).isDarkMode,

              // Quando o usuário alterna o switch
              onChanged: (value) => Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).toggleTheme(), // muda o tema claro/escuro
            ),
          ],
        ),
      ),
    );
  }
}
