import 'package:chat_flutter/themes/dark_mode.dart';
import 'package:chat_flutter/themes/light_mode.dart';
import 'package:flutter/material.dart';

/// Provider que gerencia o tema do app (Light ou Dark)
class ThemeProvider extends ChangeNotifier {
  // Tema atual do app, padrão é lightMode
  ThemeData _themeData = lightMode;

  // Getter para obter o tema atual
  ThemeData get themeData => _themeData;

  // Verifica se o tema atual é o darkMode
  bool get isDarkMode => _themeData == darkMode;

  // Setter para alterar o tema, notifica listeners para atualizar a UI
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners(); // informa widgets que usam este provider que houve mudança
  }

  /// Alterna entre lightMode e darkMode
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode; // muda para dark
    } else {
      themeData = lightMode; // muda para light
    }
  }
}
