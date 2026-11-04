import 'package:flutter/material.dart';
import '../../data/colors.dart';
import 'change_password_dialog.dart'; // путь к нашему диалогу

class ChangePasswordPlate extends StatefulWidget {
  final double borderRadius;

  const ChangePasswordPlate({
    super.key,
    this.borderRadius = 16.0,
  });

  @override
  State<ChangePasswordPlate> createState() => _ChangePasswordPlateState();
}

class _ChangePasswordPlateState extends State<ChangePasswordPlate> {
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
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: () {
          // Открываем наш двойной диалог смены пароля:
          showDialog(
            context: context,
            builder: (context) => const ChangePasswordDialog(),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16 - borderDiff,
            vertical: 14 - borderDiff,
          ),
          decoration: BoxDecoration(
            color: BColors.mainColor, // Серая плашка
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: isActive ? BColors.outlineFocused : BColors.outlineUnFocused,
              width: isActive ? 3.5 : 2.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // сожмется ровно по содержимому
            children: [
              // Черная иконка ключа:
              Icon(
                Icons.vpn_key_rounded,
                color: BColors.textColor, // Черный цвет
                size: 24,
              ),
              const SizedBox(width: 12),

              // Белый текст:
              Text(
                'Поменять пароль',
                style: TextStyle(
                  color: BColors.textColor, // Белый цвет
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}