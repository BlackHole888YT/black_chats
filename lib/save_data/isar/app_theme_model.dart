import 'package:black_chats/data/colors.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'app_theme_model.g.dart';

// dart run build_runner build --delete-conflicting-outputs
@collection
class AppThemeModel {
  Id id = 1;

  int mainColorValue = Colors.black.toARGB32();
  int textColorValue = Colors.white.toARGB32();
  int outlineUnFocusedValue = Colors.grey.shade700.toARGB32();
  int outlineFocusedValue = Color(0xFFBB86FC).toARGB32();
  int topRightBallValue = Colors.purple.withOpacity(0.5).toARGB32();
  int topRightBallShadowValue = Colors.deepPurpleAccent.withOpacity(0.8).toARGB32();
  int bottomLeftBallValue = Colors.cyanAccent.withOpacity(0.4).toARGB32();
  int bottomLeftBallShadowValue = Colors.cyan.withOpacity(0.7).toARGB32();

  @ignore
  Color get mainColor => Color(mainColorValue);

  @ignore
  Color get textColor => Color(textColorValue);

  @ignore
  Color get outlineUnFocused => Color(outlineUnFocusedValue);

  @ignore
  Color get outlineFocused => Color(outlineFocusedValue);

  @ignore
  Color get topRightBall => Color(topRightBallValue);

  @ignore
  Color get topRightBallShadow => Color(topRightBallShadowValue);

  @ignore
  Color get bottomLeftBall => Color(bottomLeftBallValue);

  @ignore
  Color get bottomLeftBallShadow => Color(bottomLeftBallShadowValue);
}