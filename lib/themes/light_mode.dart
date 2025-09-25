import 'package:flutter/material.dart';

/// Tema claro (Light Mode) do app
ThemeData lightMode = ThemeData(
  // Base do tema: Light
  colorScheme: ColorScheme.light().copyWith(
    surface: Colors.grey.shade300, // fundo de cards e scaffold
    primary: Colors.grey.shade500, // cor principal de textos e ícones
    secondary: Colors.grey.shade200, // cor secundária para botões e highlights
    tertiary: Colors.white, // cor terciária para borders e campos de input
    inversePrimary: Colors
        .grey
        .shade800, // cor invertida para textos ou elementos de destaque
  ),

  // AppBar transparente
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent, // sem cor de fundo
    foregroundColor: Colors.white, // cor do texto e ícones
    elevation: 0, // sem sombra
  ),
);
