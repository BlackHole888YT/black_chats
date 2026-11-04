import 'package:black_chats/data/solo_data/user_name_converter.dart';
import 'package:black_chats/data/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../save_data/shared_preferences/shared_preferences.dart';

class BSupaBase {
  static final supabase = Supabase.instance.client;

  static Future<bool> registerUser({
    required String name,
    required String password,
    required BuildContext context
  }) async {
    String login = UserNameConverter.run(name);
    try {
      final existingUsers = await supabase
          .from('users').select().eq('user_login', login);
      if (existingUsers.isNotEmpty) {
        BWidgets.showErrorSnackBar(context, "Логин уже занят!");
        return false;
      }
      await supabase.from('users').insert({
        'user_name': name,
        'user_login': login,
        'user_password': password,
      });
      return true;
    } catch (e) {
      BWidgets.showErrorSnackBar(context, "Ошибка регистрации: $e");
      print("Ошибка регистрации: $e");
      return false;
    }
  }

  static Future<bool> loginUser({
    required String login,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // 1. Ищем пользователя СТРОГО по логину (всего один запрос к серверу!):
      final user = await supabase
          .from('users')
          .select()
          .eq('user_login', login)
          .maybeSingle();

      // 2. Если логина вообще нет в базе:
      if (user == null) {
        if (context.mounted) {
          BWidgets.showErrorSnackBar(context, "Пользователь с таким логином не найден!");
        }
        return false;
      }

      // 3. Логин есть! Теперь сверяем пароль ЭТОГО пользователя:
      if (user['user_password'] != password) {
        if (context.mounted) {
          BWidgets.showErrorSnackBar(context, "Неверный пароль!");
        }
        return false;
      }

      // 4. Всё совпало! Сохраняем имя и логин локально:
      // BSavedData.saveUser(user['user_name'], user['user_login'], user['id']);

      return true;
    } catch (e) {
      if (context.mounted) {
        BWidgets.showErrorSnackBar(context, "Ошибка входа: $e");
      }
      print("Ошибка входа: $e");
      return false;
    }
  }


  static Future<String?> getCurrentUserName() async {
    try {
      // 1. Достаем логин текущего юзера из памяти телефона:
      final String? myLogin = await BSavedData.UserName.get();

      if (myLogin == null) return null;

      // 2. Делаем запрос в Supabase:
      final data = await supabase
          .from('users')
          .select('user_name') // просим только имя
          .eq('user_login', myLogin)
          .maybeSingle();

      if (data != null) {
        return data['user_name'] as String; // вернули реальное имя из базы
      }
      return null;
    } catch (e) {
      print("Ошибка получения имени: $e");
      return null;
    }
  }
}