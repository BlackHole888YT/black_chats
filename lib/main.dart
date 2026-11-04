import 'package:black_chats/router/app_router.dart';
import 'package:black_chats/save_data/isar/main/isar_service.dart';
import 'package:black_chats/save_data/shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'backend/download_data/download_users_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://odvdmlgzngutmenkpyhd.supabase.co',
    publishableKey: 'sb_publishable_8WXwbpBbUVhcSA2M5Ul8eA_7sKGH1ap',
  );

  //print("Версия пользователя: ${await BSavedData.getSessionVersion()}");

  /// Инициализация Isar
  await IsarService.init();
  /// Скачивание всех юзеров
  await DownloadUsersData.run();

  String login = await BSavedData.UserName.get();
  final currentUser = await DownloadUsersData.getLocalUserByLogin(login);

  if (currentUser != null) {
    DownloadUsersData.currentUser = currentUser;
  } else {
    print("Пользователь не найден в локальной базе");
  }

  int localVersion = await BSavedData.SessionVersion.get();
  int serverVersion = currentUser?.sessionVersion ?? 1;

  if (localVersion == 0) {
    await BSavedData.SessionVersion.set(serverVersion!);
    print("Первичная сессия успешно установлена!");
  }
  else if (localVersion != serverVersion) {
    print("Пароль был изменен! Выход из аккаунта.");
    await BSavedData.IsLoggedIn.set(false);
  }

  bool isLogged = await BSavedData.IsLoggedIn.get();
  bool isAcceptTerms = await BSavedData.AcceptedTerms.get();

  runApp(BaseMenuScreen(isLogged: isLogged, isAcceptTerms: isAcceptTerms));
}

class BaseMenuScreen extends StatelessWidget {
  final bool isLogged;
  final bool isAcceptTerms;
  const BaseMenuScreen({super.key, required this.isLogged, required this.isAcceptTerms});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: createRouter(isLogged, isAcceptTerms)
    );
  }
}
