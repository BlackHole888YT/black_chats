import 'package:isar/isar.dart';

part 'local_user_model.g.dart';

@collection
class LocalUser {
  int get userId => id;

  Id id = 0;
  late String createdAt;
  late String userName;
  late String userLogin;
  late String avatarUrl;
  late int sessionVersion;

  LocalUser();

  // Фабрика для сборки объекта из ответа Supabase
  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser()
      ..id = json['id'] ?? 0
      ..createdAt = json['created_at']?.toString() ?? ''
      ..userName = json['user_name'] ?? ''
      ..avatarUrl = json['avatar_url'] ?? ''
      ..sessionVersion = json['session_version'] ?? 1
      ..userLogin = json['user_login'] ?? '';
  }
}
// dart run build_runner build --delete-conflicting-outputs