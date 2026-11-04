import 'bubble_model.dart';

class ChatModel {
  final int chatId;/// id чата
  final String? chatDescription;/// описание чата
  final String? chatName;/// имя чата
  final String? chatIcon;/// аватарка чата
  final bool isGroup;/// группа или нет
  final int unreadCount;/// кол-во не прочитанных
  final List<int> userList;/// список юзеров
  final bool isPinned;/// закреплен ли чат
  final bool isFavorite;/// в избранном ли чат
  final BubbleModel? lastMessage; /// последнее сообщение

  ChatModel({required this.chatId, this.chatDescription, this.chatName, this.chatIcon, required this.isGroup, required this.unreadCount, required this.userList, required this.isPinned, required this.isFavorite, this.lastMessage});
}