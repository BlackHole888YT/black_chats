import 'package:black_chats/data/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../records/records.dart';

class SquareQuestionButton extends StatefulWidget {
  final QuestionRecord data;
  final double size; // размер стороны квадрата (по умолчанию 48)

  const SquareQuestionButton({
    super.key,
    this.size = 48.0,
    required this.data,
  });

  @override
  State<SquareQuestionButton> createState() => _SquareQuestionButtonState();
}

class _SquareQuestionButtonState extends State<SquareQuestionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        context.push('/q', extra: widget.data);
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: BColors.mainColor, // внутри черная
          borderRadius: BorderRadius.circular(12), // аккуратные углы
          border: Border.all(
            // фиолетовый при клике, иначе серый:
            color: _isPressed ? BColors.purple : BColors.gray,
            width: _isPressed ? 2.5 : 1.5,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.help_outline_rounded, // 👈 квадратный/контурный знак вопроса
            color: _isPressed ? BColors.purple : BColors.gray,
            size: widget.size * 0.55, // размер иконки пропорционален кнопке
          ),
        ),
      ),
    );
  }
}