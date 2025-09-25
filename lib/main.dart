import 'package:chat_flutter/firebase_options.dart';
import 'package:chat_flutter/services/auth/auth_gate.dart';
import 'package:chat_flutter/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Função principal que inicializa o app
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que tudo do Flutter esteja pronto
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Inicializa Firebase com as configs do seu projeto
  );

  // Configura o Provider para gerenciar o tema do app
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), // Provider do tema (light/dark)
      child: const MyApp(),
    ),
  );
}

/// Widget raiz do app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove banner de debug
      title: "Meu Chat App", // Título do app
      home:
          const AuthGate(), // Tela inicial decide se mostra login ou home dependendo da autenticação
      theme: Provider.of<ThemeProvider>(
        context,
      ).themeData, // Aplica o tema atual do ThemeProvider
    );
  }
}
