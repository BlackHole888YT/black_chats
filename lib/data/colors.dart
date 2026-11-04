import 'package:flutter/material.dart';

import '../save_data/theme/theme_service.dart';

class BColors{
  static Color get purple => ThemeService.currentTheme.outlineFocused;
  static Color get gray => ThemeService.currentTheme.outlineUnFocused;

  static Color get mainColor => ThemeService.currentTheme.mainColor;
  static Color get textColor => ThemeService.currentTheme.textColor;
  static Color get outlineUnFocused => ThemeService.currentTheme.outlineUnFocused;
  static Color get outlineFocused => ThemeService.currentTheme.outlineFocused;
  static Color get topRightBall => ThemeService.currentTheme.topRightBall;
  static Color get topRightBallShadow => ThemeService.currentTheme.topRightBallShadow;
  static Color get bottomLeftBall => ThemeService.currentTheme.bottomLeftBall;
  static Color get bottomLeftBallShadow => ThemeService.currentTheme.bottomLeftBallShadow;
}