import 'package:flutter/material.dart';

import '../isar/app_theme_model.dart';
import '../isar/main/isar_service.dart';

class ThemeService {
  static AppThemeModel currentTheme = AppThemeModel();

  // Эталон дефолтных цветов (для сброса по одному)
  static final AppThemeModel _defaultTheme = AppThemeModel();

  static Future<void> init() async {
    final savedTheme = await IsarService.isar.appThemeModels.get(1);
    if (savedTheme != null) {
      currentTheme = savedTheme;
    } else {
      await saveTheme(AppThemeModel());
    }
  }

  static Future<void> saveTheme(AppThemeModel theme) async {
    theme.id = 1;
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.appThemeModels.put(theme);
    });
    currentTheme = theme;
  }

  /// 1. Получить текущий цвет по типу
  static Color getColor(AppColorType type) {
    switch (type) {
      case AppColorType.mainColor: return currentTheme.mainColor;
      case AppColorType.outlineUnFocused: return currentTheme.outlineUnFocused;
      case AppColorType.outlineFocused: return currentTheme.outlineFocused;
      case AppColorType.topRightBall: return currentTheme.topRightBall;
      case AppColorType.topRightBallShadow: return currentTheme.topRightBallShadow;
      case AppColorType.bottomLeftBall: return currentTheme.bottomLeftBall;
      case AppColorType.bottomLeftBallShadow: return currentTheme.bottomLeftBallShadow;
      case AppColorType.textColor: return currentTheme.textColor;
    }
  }

  /// 2. Изменить один конкретный цвет
  static Future<void> setSingleColor(AppColorType type, Color newColor) async {
    final updated = currentTheme;
    final int val = newColor.value;

    switch (type) {
      case AppColorType.mainColor: updated.mainColorValue = val; break;
      case AppColorType.outlineUnFocused: updated.outlineUnFocusedValue = val; break;
      case AppColorType.outlineFocused: updated.outlineFocusedValue = val; break;
      case AppColorType.topRightBall: updated.topRightBallValue = val; break;
      case AppColorType.topRightBallShadow: updated.topRightBallShadowValue = val; break;
      case AppColorType.bottomLeftBall: updated.bottomLeftBallValue = val; break;
      case AppColorType.bottomLeftBallShadow: updated.bottomLeftBallShadowValue = val; break;
      case AppColorType.textColor: updated.textColorValue = val; break;
    }

    await saveTheme(updated);
  }

  /// 3. Сбросить ТОЛЬКО ОДИН цвет к заводскому значению
  static Future<void> resetSingleColor(AppColorType type) async {
    switch (type) {
      case AppColorType.mainColor:
        await setSingleColor(type, _defaultTheme.mainColor);
        break;
      case AppColorType.outlineUnFocused:
        await setSingleColor(type, _defaultTheme.outlineUnFocused);
        break;
      case AppColorType.outlineFocused:
        await setSingleColor(type, _defaultTheme.outlineFocused);
        break;
      case AppColorType.topRightBall:
        await setSingleColor(type, _defaultTheme.topRightBall);
        break;
      case AppColorType.topRightBallShadow:
        await setSingleColor(type, _defaultTheme.topRightBallShadow);
        break;
      case AppColorType.bottomLeftBall:
        await setSingleColor(type, _defaultTheme.bottomLeftBall);
        break;
      case AppColorType.bottomLeftBallShadow:
        await setSingleColor(type, _defaultTheme.bottomLeftBallShadow);
        break;
      case AppColorType.textColor:
        await setSingleColor(type, _defaultTheme.textColor);
        break;
    }
  }
}

enum AppColorType {
  mainColor('Основной фон'),
  outlineUnFocused('Обычный контур (неактивный)'),
  outlineFocused('Активный контур (нажатие)'),
  topRightBall('Верхний правый шар'),
  topRightBallShadow('Тень/свечение верхнего шара'),
  bottomLeftBall('Нижний левый шар'),
  bottomLeftBallShadow('Тень/свечение нижнего шара'),
  textColor('Цвет текста');

  final String title;
  const AppColorType(this.title);
}