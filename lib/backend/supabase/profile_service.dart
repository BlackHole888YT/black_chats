import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../save_data/isar/local_user_model.dart';
import '../../save_data/isar/main/isar_service.dart';
import '../../save_data/shared_preferences/shared_preferences.dart';
import '../download_data/download_users_data.dart';

class ProfileService {
  static final _supabase = Supabase.instance.client;

  // 1. ЗАГРУЗКА АВАТАРКИ В SUPABASE STORAGE
  static Future<String?> uploadAvatar(File imageFile) async {
    try {
      final user = DownloadUsersData.currentUser;
      if (user == null) return null;

      final fileExt = imageFile.path.split('.').last;
      final fileName = 'user_${user.id}.$fileExt';

      // Загружаем файл в бакет (upsert: true - перезаписывает старую фотку)
      await _supabase.storage.from('avatars').upload(
        fileName,
        imageFile,
        fileOptions: const FileOptions(upsert: true),
      );

      // Получаем публичную ссылку (добавляем таймштамп, чтобы сбросить кэш картинки):
      final baseUrl = _supabase.storage.from('avatars').getPublicUrl(fileName);
      final avatarUrlWithCacheBust = '$baseUrl?v=${DateTime.now().millisecondsSinceEpoch}';

      // Обновляем ссылку в таблице users в Supabase:
      await _supabase.from('users').update({
        'avatar_url': avatarUrlWithCacheBust,
      }).eq('id', user.id);

      // Обновляем локально в Isar и в памяти:
      user.avatarUrl = avatarUrlWithCacheBust;
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.localUsers.put(user);
      });
      DownloadUsersData.currentUser = user;

      print("Аватарка успешно обновлена!");
      return avatarUrlWithCacheBust;
    } catch (e) {
      print("Ошибка загрузки аватарки: $e");
      return null;
    }
  }

  static Future<bool> updateUserName(String newName) async {
    try {
      final user = DownloadUsersData.currentUser;
      if (user == null) return false;

      // Обновляем на сервере
      await _supabase.from('users').update({
        'user_name': newName,
      }).eq('id', user.id);

      // Обновляем локально
      user.userName = newName;
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.localUsers.put(user);
      });
      DownloadUsersData.currentUser = user;

      return true;
    } catch (e) {
      print("Ошибка обновления ника: $e");
      return false;
    }
  }

  // 3. СМЕНА ПАРОЛЯ (+ Увеличение session_version!)
  static Future<bool> changePassword(String newPassword) async {
    try {
      final user = DownloadUsersData.currentUser;
      if (user == null) return false;

      // Новая версия сессии, чтобы выбросить другие устройства:
      final int newVersion = user.sessionVersion + 1;

      // Обновляем пароль и версию на сервере
      await _supabase.from('users').update({
        'password': newPassword,
        'session_version': newVersion,
      }).eq('id', user.id);

      // Синхронизируем локально нашу сессию, чтобы текущий телефон НЕ выбило:
      user.sessionVersion = newVersion;
      await BSavedData.SessionVersion.set(newVersion);
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.localUsers.put(user);
      });
      DownloadUsersData.currentUser = user;

      print("Пароль успешно сменен, чужие сессии сброшены!");
      return true;
    } catch (e) {
      print("Ошибка смены пароля: $e");
      return false;
    }
  }

  // 4. ВЫХОД ИЗ АККАУНТА (Logout)
  static Future<void> logout(BuildContext context) async {
    DownloadUsersData.currentUser = null;
    await BSavedData.ClearUserData.runAndQuit(context);
    print("Пользователь вышел из аккаунта.");
  }
}