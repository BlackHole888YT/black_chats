import 'package:flutter/material.dart';
import '../../../data/colors.dart';

class CustomBorderButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const CustomBorderButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<CustomBorderButton> createState() => _CustomBorderButtonState();
}

class _CustomBorderButtonState extends State<CustomBorderButton> {
  bool _isHovered = false; // нацеливание мышкой
  bool _isPressed = false; // нажатие пальцем/кликом

  @override
  Widget build(BuildContext context) {
    // Активна, если навели мышь ИЛИ зажали кнопку:
    final bool isHighlighted = _isHovered || _isPressed;

    return MouseRegion(
      // Отслеживаем наведение мышки (hover):
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        // Отслеживаем клик/нажатие:
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: Colors.black, // внутри черная
            borderRadius: BorderRadius.circular(16), // аккуратное скругление
            border: Border.all(
              color: isHighlighted ? BColors.purple : BColors.gray, // серый / фиолетовый
              width: isHighlighted ? 2.5 : 2.0, // 2.0 в покое, 2.5 при нажатии/наведении
            ),
          ),
          child: Center(
            child: Text(
              widget.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white, // белый текст
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}