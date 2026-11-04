import 'package:flutter/material.dart';

import '../colors.dart';

class NextButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;

  const NextButton({
    super.key,
    required this.onTap,
    this.text = "Далее",
  });

  @override
  State<NextButton> createState() => _NextButton();
}

class _NextButton extends State<NextButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Мгновенно при касании:
      onTapDown: (_) => setState(() => _isPressed = true),
      // Возврат при отпускании:
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          color: Colors.black, // внутри черная
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            // Сразу фиолетовый или серый:
            color: _isPressed ? BColors.purple : BColors.gray,
            // Сразу 3.5 или 2.0:
            width: _isPressed ? 3.5 : 2.0,
          ),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.grey, // текст серый
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}