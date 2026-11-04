import 'package:black_chats/data/solo_data/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../bottom_navigation/app_nav_bar.dart';
import '../../bottom_navigation/nav_bar_nums.dart';
import '../../data/colors.dart';
import '../../data/solo_data/bchat.dart';
import '../../data/solo_data/glass_background.dart';
import '../../data/widgets.dart';

import '../../save_data/theme/theme_service.dart';

class CustomizationScreen extends StatefulWidget {
  const CustomizationScreen({super.key});

  @override
  State<CustomizationScreen> createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  // Метод, чтобы наполнить подсказки для каждой плашки по-разному
  ({String title, String description}) _getQuestionData(AppColorType type) {
    switch (type) {
      case AppColorType.mainColor:
        return (title: 'Главный фон', description: 'Цвет подложки всех экранов приложения');
      case AppColorType.outlineUnFocused:
        return (title: 'Обычная рамка', description: 'Цвет обводки кнопок и карточек в покое, а так же некоторого текста');
      case AppColorType.outlineFocused:
        return (title: 'Активная рамка', description: 'Цвет обводки элементов при нажатии или нацеливании на ПК');
      case AppColorType.topRightBall:
        return (title: 'Верхний шар', description: 'Цвет неонового шара в правом верхнем углу');
      case AppColorType.topRightBallShadow:
        return (title: 'Тень/свечение шара', description: 'Цвет рассеиваемого света верхнего шара');
      case AppColorType.bottomLeftBall:
        return (title: 'Нижний шар', description: 'Цвет шара в левом нижнем углу');
      case AppColorType.bottomLeftBallShadow:
        return (title: 'Тень/свечение нижнего шара', description: 'Цвет рассеиваемого света нижнего шара');
      case AppColorType.textColor:
        return (title: 'Цвет текста', description: 'Цвет всего текста в приложении');
    }
  }

  void _openColorPicker(AppColorType type) {
    Color selectedColor = ThemeService.getColor(type);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BColors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: BColors.gray, width: 1.5),
          ),
          title: Text(
            type.title,
            style: TextStyle(color: BColors.textColor, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (newColor) {
                selectedColor = newColor;
              },
              enableAlpha: true,
              displayThumbColor: true,
              pickerAreaHeightPercent: 0.7,
              labelTypes: const [],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Отмена', style: TextStyle(color: BColors.textColor)),
            ),
            TextButton(
              onPressed: () async {
                await ThemeService.setSingleColor(type, selectedColor);
                Navigator.of(context).pop();
                setState(() {});
              },
              child: Text(
                'Применить',
                style: TextStyle(
                  color: BColors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: AppNavBar(pageNum: NavBarNumbers.customizationScreen),
          appBar: BWidgets.transparentAppBar(
            titleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BChat.getName(fontSize: 32),
                Text(" ", style: TextStyle(fontSize: 32, color: BColors.textColor)),
                Text("- Кастомизация", style: TextStyle(fontSize: 32, color: BColors.textColor)),
              ],
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // Генерируем плашки настроек для каждого цвета
                    ...AppColorType.values.map((type) {
                      final currentColor = ThemeService.getColor(type);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            // 👇 ВОТ ЗДЕСЬ БЫЛА ОШИБКА: Обернули Container в Expanded!
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: BColors.mainColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: BColors.outlineUnFocused, width: 1.5),
                                ),
                                child: Row(
                                  children: [
                                    // 1. Кружок цвета (клик открывает палитру)
                                    GestureDetector(
                                      onTap: () => _openColorPicker(type),
                                      child: Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          color: currentColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: BColors.outlineUnFocused, width: 2),
                                          boxShadow: [
                                            BoxShadow(
                                              color: currentColor.withOpacity(0.5),
                                              blurRadius: 6,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),

                                    // 2. Название параметра
                                    Expanded(
                                      child: Text(
                                        type.title,
                                        style: TextStyle(
                                          color: BColors.textColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),

                                    // 3. Кнопка сброса ТОЛЬКО ЭТОГО цвета
                                    IconButton(
                                      icon: Icon(Icons.refresh, color: BColors.gray, size: 22),
                                      tooltip: 'Сбросить цвет',
                                      onPressed: () async {
                                        await ThemeService.resetSingleColor(type);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            // Твоя кнопка-вопрос справа:
                            SquareQuestionButton(
                              data: _getQuestionData(type),
                              size: 32,
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}