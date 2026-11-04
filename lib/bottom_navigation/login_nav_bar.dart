import 'package:black_chats/methods/b_methods.dart';
import 'package:flutter/material.dart';

class LoginNavBar extends StatelessWidget {
  final bool isLogin;

  const LoginNavBar({
    super.key,
    required this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: _AuthButton(
                text: "Вход",
                isActive: isLogin,
                onTap: () {
                  if (!isLogin) BMethods.onJoinButtonTap(context);
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _AuthButton(
                text: "Регистрация",
                isActive: !isLogin,
                onTap: () {
                  if (isLogin) BMethods.onRegisterButtonTap(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthButton extends StatefulWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _AuthButton({
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<_AuthButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isHighlighted = widget.isActive || _isPressed;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHighlighted ? const Color(0xFFBB86FC) : Colors.grey.shade700,
            width: isHighlighted ? 3.5 : 2.0,
          ),
        ),
        child: Center(
          child: Text(
            widget.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey, // СТРОГО СЕРЫЙ ВСЕГДА
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}