import 'package:flutter/material.dart';
import 'package:social_media_app/data/models/user_model.dart';
import 'package:social_media_app/presentation/controllers/user_controller.dart';
import 'package:social_media_app/presentation/utils/shared_preferences_helper.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = true;

  User? get user => _user;
  bool get isLoading => _isLoading;

  // Carrega usuário do SharedPreferences
  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    _user = await SharedPreferencesHelper.getUserData();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    try {
      final updated = await getUserProfileRequest(_user!.id!);
      setUser(updated);
    } catch (e) {
      print('Erro ao carregar usuário logado: $e');
    }
  }

  // Atualiza e salva o usuário no SharedPreferences
  Future<void> setUser(User newUser) async {
    _user = newUser;
    await SharedPreferencesHelper.setUserData(newUser);
    notifyListeners();
  }

  // Método para limpar os dados do usuário
  Future<void> clear() async {
    _user = null;
    notifyListeners();
  }
}
