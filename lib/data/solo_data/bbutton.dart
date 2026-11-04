import 'package:flutter/material.dart';
import '../../data/colors.dart';

class BButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final double borderRadius;
  final bool isLoading;

  const BButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius = 12.0, // Единое базовое скругление для всего проекта
    this.isLoading = false,
  });

  @override
  State<BButton> createState() => _BButtonState();
}

class _BButtonState extends State<BButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Активно, если навели мышь ИЛИ зажали пальцем:
    final bool isActive = _isHovered || _isPressed;

    // Компенсация паддинга (3.5 - 2.0 = 1.5), чтобы кнопка не дергалась при наведении:
    final double borderDiff = isActive ? 1.5 : 0.0;

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 18 - borderDiff,
            vertical: 10 - borderDiff,
          ),
          decoration: BoxDecoration(
            color: BColors.mainColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: isActive ? BColors.outlineFocused : BColors.outlineUnFocused,
              width: isActive ? 3.5 : 2.0,
            ),
          ),
          child: Center(
            widthFactor: 1.0,
            child: widget.isLoading
                ? SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: BColors.textColor,
              ),
            )
                : Text(
              widget.text,
              style: TextStyle(
                color: BColors.textColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}