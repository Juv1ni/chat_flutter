import 'package:flutter/material.dart';

/// Tema escuro (Dark Mode) do app
ThemeData darkMode = ThemeData(
  // Base do tema: Dark
  colorScheme: ColorScheme.dark().copyWith(
    surface: Colors.grey.shade900, // cor de fundo de cards, scaffold
    primary: Colors.grey.shade600, // cor principal, usada em textos e ícones
    secondary:
        Colors.grey.shade700, // cor secundária, usada em botões e highlights
    tertiary: Colors
        .grey
        .shade800, // cor terciária, usada para borders, textfields, etc.
    inversePrimary:
        Colors.grey.shade300, // cor invertida para textos em dark mode
  ),

  // AppBar transparente
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent, // sem cor de fundo
    foregroundColor: Colors.white, // cor do texto e ícones
    elevation: 0, // sem sombra
  ),
);
