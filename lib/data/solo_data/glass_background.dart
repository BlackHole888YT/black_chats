import 'dart:ui';
import 'package:flutter/material.dart';

import '../colors.dart';

class GlassBackground extends StatelessWidget {
  final Widget child;

  const GlassBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF090A0F), // Базовый темный цвет космоса
      child: Stack(
        children: [
          // 1. Фиолетовый яркий шар в правом верхнем углу
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BColors.topRightBall,
                boxShadow: [
                  BoxShadow(
                    color: BColors.topRightBallShadow,
                    blurRadius: 120,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),

          // 2. Сине-бирюзовый яркий шар в левом нижнем углу
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BColors.bottomLeftBall,
                boxShadow: [
                  BoxShadow(
                    color: BColors.bottomLeftBallShadow,
                    blurRadius: 130,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          // 3. Слой "мокрого матового стекла" (размывает свечение в мягкий туман)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: Container(
                // Полупрозрачная серая дымка
                color: BColors.mainColor.withOpacity(0.35),
              ),
            ),
          ),

          // 4. Твой интерфейс
          child,
        ],
      ),
    );
  }
}