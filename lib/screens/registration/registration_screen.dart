import 'package:black_chats/data/solo_data/next_button.dart';
import 'package:black_chats/data/solo_data/question_widget.dart';
import 'package:black_chats/methods/b_methods.dart';
import 'package:flutter/material.dart';

import '../../bottom_navigation/login_nav_bar.dart';
import '../../data/colors.dart';
import '../../data/solo_data/bchat.dart';
import '../../data/widgets.dart';

class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({
    super.key
  });

  @override
  State<StatefulWidget> createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen> {

  final TextEditingController _passwordControllerFirst = TextEditingController();
  final TextEditingController _passwordControllerSecond = TextEditingController();
  final TextEditingController _nameController = TextEditingController();


  @override
  void dispose() {
    _passwordControllerFirst.dispose();
    _passwordControllerSecond.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: LoginNavBar(isLogin: false,),
      backgroundColor: BColors.mainColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 110,),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Добро пожаловать в ",
                    style: TextStyle(
                      color: BColors.textColor,
                      fontSize: 32,
                    ),
                  ),
                  BChat.getName(fontSize: 32),
                  Text(
                    "!",
                    style: TextStyle(
                      color: BColors.textColor,
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              Text(
                "Регистрация",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: BColors.gray,
                    fontSize: 32
                ),
              ),
              const SizedBox(height: 32,),
              Row(
                children: [
                  Expanded(
                    child: BWidgets.registrationTextFieldName(controller: _nameController),
                  ),
                  SizedBox(width: 10,),
                  SquareQuestionButton(data: (
                  title: 'Регистрация - Имя',
                  description: 'Сейчас вы пишите ваше имя (или ник), который видят все пользователи. '
                  'Поменять его можно, но так же все остальные увидят его новый вариант. '
                  'Ваш логин автоматически создается первый раз при регистрации относительно вашего ника. '
                  'Логин нужен вам для входа в ваш аккаунт. Не забудьте его. '),
                  size: 48,)
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(
                    child: BWidgets.registrationTextFieldPassword(controller: _passwordControllerFirst),
                  ),
                  SizedBox(width: 10,),
                  SquareQuestionButton(data: (
                  title: 'Регистрация - Пароль',
                  description: 'Это ваш пароль. Он нужен для регистрации и входа в ваш аккаунт. Без него вы навсегда потеряете доступ к вашему аккаунту. Случайный пробел в конце пароля не засчитается.'),
                    size: 48,)
                ],
              ),

              const SizedBox(height: 15,),

              Row(
                children: [
                  Expanded(
                    child: BWidgets.registrationTextFieldRepeatPassword(controller: _passwordControllerSecond),
                  ),
                  SizedBox(width: 10,),
                  SquareQuestionButton(data: (
                  title: 'Регистрация - Повтор пароля',
                  description: 'Нужен для того, чтобы убедиться, что вы верно ввели нужный пароль.'),
                    size: 48,)
                ],
              ),

              const SizedBox(height: 32,),
              NextButton(
                  onTap: () {
                    String name = _nameController.text.trim();
                    String mainPass = _passwordControllerFirst.text.trim();
                    String secondPass = _passwordControllerSecond.text.trim();

                    if (name.isEmpty || mainPass.isEmpty || secondPass.isEmpty) {
                      BWidgets.showErrorSnackBar(context, "Заполните все поля!");
                      return;
                    }

                    if (mainPass.length < 6) {
                      BWidgets.showErrorSnackBar(context, "Пароль должен быть от 6 символов!");
                      return;
                    }

                    if (mainPass != secondPass) {
                      BWidgets.showErrorSnackBar(context, "Пароли не совпадают!");
                      return;
                    }

                    BMethods.onPressNext(
                      context, (name: name, password: mainPass, isRegister: true),
                    );
                  },
              )
            ],
          ),
        )
      ),
    );
  }
}