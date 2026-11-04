import 'package:black_chats/data/colors.dart';
import 'package:flutter/material.dart';


class SquareEditButton extends StatefulWidget {
  final double size; // размер стороны квадрата (по умолчанию 32)
  final VoidCallback? cb;
  final double borderRadius;

  const SquareEditButton({
    super.key,
    this.size = 32.0,
    this.borderRadius = 10.0,
    this.cb,
  });

  @override
  State<SquareEditButton> createState() => _SquareEditButtonState();
}

class _SquareEditButtonState extends State<SquareEditButton> {
  bool _isHovered = false; // Наведение мыши (ПК / веб)
  bool _isPressed = false; // Нажатие пальцем / клик

  @override
  Widget build(BuildContext context) {
    // Активно, если навели курсор ИЛИ зажали:
    final bool isActive = _isHovered || _isPressed;

    return MouseRegion(
      cursor: widget.cb != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.cb?.call();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: BColors.mainColor, // Внутри цвет фона
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              // Наш стандарт: 3.5 фиолетовый при наведении, 2.0 серый в покое
              color: isActive ? BColors.outlineFocused : BColors.outlineUnFocused,
              width: isActive ? 3.5 : 2.0,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.edit_sharp,
              color: BColors.outlineUnFocused,
              size: widget.size * 0.55,
            ),
          ),
        ),
      ),
    );
  }
}