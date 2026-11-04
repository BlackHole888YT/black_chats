import '../save_data/isar/local_user_model.dart';

class UserDataModel {
  final int userId;/// id пользователя - порядковый регистрационный номер
  final String userName;/// имя пользователя - имя пользователя, на любом языке
  final String userNameId;/// name_id пользователя - id пользователя на английском, например если ник- Никита -> nikita
  final String? icon;/// аватарка пользователя
  final DateTime lastSeen;/// последнее время в сети
  final bool isOnline;/// онлайн ли пользователь
  final bool isTyping;/// печатает или нет
  final String? aboutMe;/// о себе
  final String? title;/// приписка
  final String? role; /// роль в групповом чате

  UserDataModel({
    required this.userId, required this.userName, required this.userNameId, this.icon, required this.lastSeen, required this.isOnline, required this.aboutMe, required this.title, required this.isTyping, this.role
  });

  factory UserDataModel.fromLocalUser(
      LocalUser user, {
        bool isOnline = false,
        bool isTyping = false,
        DateTime? lastSeen,
        String? role,
      }) {
    return UserDataModel(
      userId: user.id,
      userName: user.userName,
      userNameId: user.userLogin,
      icon: user.avatarUrl,
      aboutMe: null,// user.aboutMe,
      title: null,// user.title,
      isOnline: isOnline,
      isTyping: isTyping,
      lastSeen: lastSeen ?? DateTime.now(),
      role: role,
    );
  }
}

