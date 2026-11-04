import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notifier/local_notifier.dart';

class NotificationService {
  // Плагин для мобилок:
  static final FlutterLocalNotificationsPlugin _mobilePlugin =
  FlutterLocalNotificationsPlugin();

  /// 1. Инициализация (вызывается 1 раз в main.dart)
  static Future<void> init() async {
    if (kIsWeb) return;

    // ЕСЛИ ЭТО ПК (Windows / macOS / Linux):
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      await localNotifier.setup(
        appName: 'Black Chats',
        // Создает ярлык в меню пуск Windows для тостов:
        shortcutPolicy: ShortcutPolicy.requireCreate,
      );
    }
    // ЕСЛИ ЭТО ТЕЛЕФОН (Android / iOS):
    else if (Platform.isAndroid || Platform.isIOS) {
      const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _mobilePlugin.initialize(settings);

      // Запрос разрешения на Android 13+:
      if (Platform.isAndroid) {
        await _mobilePlugin
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      }
    }

    print("Система уведомлений готова!");
  }

  /// 2. Главный метод показа уведомления
  static Future<void> show({
    required String title,
    required String body,
    bool playSound = true, // Сюда подставишь свой тумблер звука из SharedPreferences
  }) async {
    if (kIsWeb) return;

    // --- ПОКАЗ НА ПК (Windows) ---
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      LocalNotification notification = LocalNotification(
        title: title,
        body: body,
        silent: !playSound, // выключает звук, если playSound = false
      );
      await notification.show();
    }
    // --- ПОКАЗ НА ТЕЛЕФОНЕ (Android / iOS) ---
    else if (Platform.isAndroid || Platform.isIOS) {
      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'chat_messages_channel',
        'Сообщения чата',
        channelDescription: 'Уведомления о новых сообщениях',
        importance: Importance.max,
        priority: Priority.high,
        playSound: playSound,
      );

      NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(presentSound: playSound),
      );

      await _mobilePlugin.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000, // уникальный ID
        title,
        body,
        platformDetails,
      );
    }
  }
}