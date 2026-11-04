import 'package:black_chats/data/solo_data/registration_password_field.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class BWidgets{

  static Widget invisibleField(Widget w) {
    return IgnorePointer(
      ignoring: true,
      child: Opacity(
        opacity: 0.0,
        child: w,
      ),
    );
  }

  static Widget registrationTextFieldLogin({TextEditingController? controller}){
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w800
      ),
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500
        ),
        fillColor: Colors.black,
        hintText: 'Введите ваш логин',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
      ),
    );
  }

  static Widget registrationTextFieldName({TextEditingController? controller}){
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w800
      ),
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500
        ),
        fillColor: Colors.black,
        hintText: 'Введите имя (не логин, ваш ник!)',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: BColors.purple, width: 1.5), // фиолетовая рамка
        ),
        content: Text(
          message,
          style: TextStyle(color: BColors.gray, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static PreferredSizeWidget transparentAppBar({
    required Widget titleWidget,
  }) {
    return AppBar(
      centerTitle: true,
      title: titleWidget,
      elevation: 0,
      backgroundColor: Colors.grey.shade900.withOpacity(0.5),
      surfaceTintColor: Colors.transparent,
    );
  }

  static Widget registrationTextFieldPassword({TextEditingController? controller}){
    return RegistrationPasswordField(controller: controller, isRepeat: false,);
  }

  static Widget registrationTextFieldRepeatPassword({TextEditingController? controller}){
    return RegistrationPasswordField(controller: controller, isRepeat: true,);
  }

}