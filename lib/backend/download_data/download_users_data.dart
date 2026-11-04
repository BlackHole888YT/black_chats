import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';

import '../../save_data/isar/local_user_model.dart';
import '../../save_data/isar/main/isar_service.dart';


class DownloadUsersData {
  static final _supabase = Supabase.instance.client;
  static LocalUser? currentUser;

  /// Метод скачивает всех пользователей из Supabase и перезаписывает Isar
  static Future<void> run() async {
    try {
      final List<dynamic> response = await _supabase.from('users').select();

      final users = response
          .map((userJson) => LocalUser.fromJson(userJson as Map<String, dynamic>))
          .toList();

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.localUsers.clear();
        await IsarService.isar.localUsers.putAll(users);
      });

      print("Синхронизировано пользователей: ${users.length}");
    } catch (e) {
      print("Ошибка при синхронизации пользователей: $e");
      // Если пропал интернет, приложение продолжит работать со старыми данными из Isar
    }
  }

  /// Получаем пользователя по логину из локальной базы Isar
  static Future<LocalUser?> getLocalUserByLogin(String login) async {
    return await IsarService.isar.localUsers
        .filter()
        .userLoginEqualTo(login)
        .findFirst();
  }

  /// Бонус: теперь ты можешь мгновенно доставать юзера прямо по ID!
  static Future<LocalUser?> getLocalUserById(int id) async {
    return await IsarService.isar.localUsers.get(id);
  }
}