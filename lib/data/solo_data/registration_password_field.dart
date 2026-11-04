import 'package:flutter/material.dart';

import '../colors.dart';

class RegistrationPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isRepeat;

  const RegistrationPasswordField({super.key, this.controller, required this.isRepeat});

  @override
  State<RegistrationPasswordField> createState() => _RegistrationPasswordFieldState();
}

class _RegistrationPasswordFieldState extends State<RegistrationPasswordField> {
  // По умолчанию скрыто (true) и глаз перечеркнут
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: const TextStyle(
        color: Colors.grey, // вводимый текст серый
        fontWeight: FontWeight.w800
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black,
        hintText: widget.isRepeat? 'Повторите пароль' : 'Введите пароль',
        hintStyle: const TextStyle(
          color: Colors.grey, // подсказка серая
          fontWeight: FontWeight.w500
        ),
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        // Кнопка переключения глазика:
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText; // меняем состояние
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: BColors.gray,
            width: 2.0,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: BColors.purple,
            width: 3.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}