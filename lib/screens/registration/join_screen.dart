import 'package:black_chats/data/solo_data/bchat.dart';
import 'package:black_chats/data/solo_data/next_button.dart';
import 'package:black_chats/methods/b_methods.dart';
import 'package:flutter/material.dart';

import '../../bottom_navigation/login_nav_bar.dart';
import '../../data/colors.dart';
import '../../data/solo_data/question_widget.dart';
import '../../data/widgets.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({
    super.key
  });

  @override
  State<StatefulWidget> createState() => _JoinScreen();
}

class _JoinScreen extends State<JoinScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();


  @override
  void dispose() {
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: LoginNavBar(isLogin: true,),
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
                "Вход",
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
                    child: BWidgets.registrationTextFieldLogin(controller: _nameController),
                  ),
                  SizedBox(width: 10,),
                  SquareQuestionButton(data: (
                  title: 'Вход - логин',
                  description:
                    'Тут вы должны ввести свой логин. Логин находится в Профиле. Без доступа к нему вы не сможете войти в аккаунт.'
                    'Не сообщайте кому-либо пароль и логин от вашего аккаунта, иначе он получит доступ ко всем вашим перепискам.'),
                    size: 48,)
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(
                    child: BWidgets.registrationTextFieldPassword(controller: _passwordController),
                  ),
                  SizedBox(width: 10,),
                  SquareQuestionButton(data: (
                  title: 'Вход - Пароль',
                  description: 'Поле для ввода вашего пароля. После успешного ввода логина и пароля вы сможете войти в ваш аккаунт. Если у вас еще нет аккаунта, зарегистрируйтесь, нажав на соответствующую кнопку ниже.'),
                    size: 48,)
                ],
              ),
              const SizedBox(height: 15,),
              BWidgets.invisibleField(BWidgets.registrationTextFieldLogin()),
              const SizedBox(height: 32,),
              NextButton(
                onTap: () {
                  String pass = _passwordController.text.trim();
                  String name = _nameController.text.trim();
                  BMethods.onPressNext(context, (name: name, password: pass, isRegister: false));
                },
              )
            ],
          ),
        )
      ),
    );
  }
}