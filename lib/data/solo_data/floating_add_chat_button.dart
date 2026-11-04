import 'package:flutter/material.dart';
import '../../data/colors.dart'; // путь к твоим BColors

class FloatingAddChatButton extends StatefulWidget {
  final VoidCallback onTap;
  final double size;
  final double borderRadius;

  const FloatingAddChatButton({
    super.key,
    required this.onTap,
    this.size = 56.0,          // Стандартный размер FAB
    this.borderRadius = 16.0,  // Наше настраиваемое скругление
  });

  @override
  State<FloatingAddChatButton> createState() => _FloatingAddChatButtonState();
}

class _FloatingAddChatButtonState extends State<FloatingAddChatButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isActive = _isHovered || _isPressed;
    final double borderDiff = isActive ? 1.5 : 0.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          width: widget.size,
          height: widget.size,
          padding: EdgeInsets.all(borderDiff > 0 ? 0 : 0), // монолитный размер
          decoration: BoxDecoration(
            color: BColors.mainColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: isActive ? BColors.outlineFocused : BColors.outlineUnFocused,
              width: isActive ? 3.5 : 2.0,
              strokeAlign: BorderSide.strokeAlignCenter, // чтобы не прыгала
            ),
          ),
          child: Center(
            child: Icon(
              Icons.add_rounded,
              color: BColors.textColor, // Черный плюс!
              size: widget.size * 0.6,
            ),
          ),
        ),
      ),
    );
  }
}