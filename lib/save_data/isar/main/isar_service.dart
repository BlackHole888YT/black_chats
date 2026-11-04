import 'package:black_chats/save_data/isar/app_theme_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../local_user_model.dart';

class IsarService {
  static late Isar isar;

  // Метод инициализации:
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [
        LocalUserSchema,
        AppThemeModelSchema
      ],
      directory: dir.path,
    );
    print("Isar успешно запущен!");
  }
}