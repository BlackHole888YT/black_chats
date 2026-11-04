import 'package:black_chats/data/solo_data/user_name_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BSavedData{
  static final Notifications = _Notifications();
  static final AcceptedTerms = _AcceptedTerms();
  static final SessionVersion = _SessionVersion();
  static final UserName = _UserName();
  static final IsLoggedIn = _IsLoggedIn();
  static final UserLogin = _UserLogin();
  static final ClearAllData = _ClearAllData();
  static final ClearUserData = _ClearUserData();
}
/// Вернуть всю дату к заводским настройкам
class _ClearAllData{
  Future<void> run()async{
    await BSavedData.AcceptedTerms.set(false);
    await BSavedData.Notifications.set(true);
    await BSavedData.SessionVersion.set(0);
    await BSavedData.UserName.set('');
    await BSavedData.IsLoggedIn.set(false);
    await BSavedData.UserLogin.set('');
  }
}
/// Очистить данные пользователя
class _ClearUserData{
  Future<void> run()async{
    await BSavedData.UserName.set('');
    await BSavedData.UserLogin.set('');
    await BSavedData.SessionVersion.set(0);
  }

  Future<void> runAndQuit(BuildContext context)async{
    await BSavedData.UserName.set('');
    await BSavedData.UserLogin.set('');
    await BSavedData.SessionVersion.set(0);
    await BSavedData.IsLoggedIn.set(false);
    if (context.mounted) context.go('/registrarScreen');
  }
}

/// Включить/Выключить уведомления
class _Notifications{
  static final notificationsSound = 'notifications_sound';

  Future<void> set(bool value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(notificationsSound, value);
  }

  Future<bool> get() async{
    final prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool(notificationsSound) ?? true;
    return val;
  }
}

/// Принял ли пользователь пользовательское соглашение
class _AcceptedTerms {
  static final isAcceptedTerms = 'is_accepted_terms';
  Future<void> set(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isAcceptedTerms, value);
  }

  Future<bool> get() async{
    final prefs = await SharedPreferences.getInstance();
    bool log = prefs.getBool(isAcceptedTerms)?? false;
    return log;
  }
}

/// Версия сессии (меняется при смене пароля для разлогина)
class _SessionVersion{
  static final sessionVersion = 'session_version';

  Future<void> set(int version) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(sessionVersion, version);
  }

  Future<int> get() async{
    final prefs = await SharedPreferences.getInstance();
    int ver = prefs.getInt(sessionVersion)?? 1;
    return ver;
  }
}

/// Имя пользователя
class _UserName{
  static final userName = 'user_name';

  Future<void> set(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userName, name);
  }

  Future<String> get() async{
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(userName)?? '';
    return name;
  }
}

/// Выполнен ли вход/регистрация
class _IsLoggedIn{
  static final isLoggedIn = 'is_logged_in';

  Future<void> set(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedIn, value);
  }

  Future<bool> get() async{
    final prefs = await SharedPreferences.getInstance();
    bool log = prefs.getBool(isLoggedIn)?? false;
    return log;
  }
}

/// Логин пользователя
class _UserLogin {
  static final userLogin = 'user_login';

  /// Конвертирует имя в логин автоматически
  Future<void> set(String name) async {
    await setRaw(UserNameConverter.run(name));
  }

  /// Ставит логин напрямую без конвертации
  Future<void> setRaw(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userLogin, name);
  }

  Future<String> get() async{
    final prefs = await SharedPreferences.getInstance();
    String login = prefs.getString(userLogin)?? '';
    return login;
  }
}