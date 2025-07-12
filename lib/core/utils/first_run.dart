import 'package:shared_preferences/shared_preferences.dart';

class FirstRunChecker {
  static const String _firstRunKey = 'isFirstRun';

  // Vérifie si c'est la première exécution
  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool(_firstRunKey) ?? true;
    
    if (isFirstRun) {
      // Marque que l'app a déjà été lancée
      await prefs.setBool(_firstRunKey, false);
    }
    
    return isFirstRun;
  }
  
  // Méthode pour réinitialiser (utile pour les tests)
  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstRunKey, true);
  }
}