class BubbleModel {
  final String dateTime;/// Дата отправки - время снизу сообщения
  final Map<int, DateTime> readBy;/// Дата прочтения сообщения каждым пользователем - время в данных о сообщении
  final String? text;/// Содержание сообщения - Текст и/или смайлики
  final String? image;/// Содержание сообщения - Фото
  final int userId;/// id пользователя, который это отправил - ник, аватарка
  final int messageId;/// id сообщения - скрытое имя всего сообщения
  final bool edited;/// отредактированно или нет - bool параметр, для отображения надписи о редактировании
  final bool isReadByAll;/// прочитано ли сообщение всеми пользователями чата - bool параметр для двух синих галочек

  BubbleModel({
    required this.dateTime, required this.readBy, this.text, this.image, required this.userId, required this.messageId, required this.edited, required this.isReadByAll
  });
}