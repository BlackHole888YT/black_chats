import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/colors.dart';
import '../../data/solo_data/bchat.dart';
import '../../data/solo_data/custom_border_button.dart';
import '../../save_data/shared_preferences/shared_preferences.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0,
        title: const Text(
          "Правила и условия",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Условия использования ",
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          BChat.getName(fontSize: 22),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Пожалуйста, внимательно прочитайте правила перед началом общения.",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 24),

                      _buildRuleItem("1", "Уважение к участникам", "Запрещены оскорбления, спам, травля и неадекватное поведение в любых чатах. В будущем планируется система очков."),
                      _buildRuleItem("2", "Безопасность данных", "Не передавайте свои пароли и логины третьим лицам, мы не можем выгнать других людей с вашего аккаунта. Однако вы можете сменить пароль в любой момент."),
                      _buildRuleItem("3", "Ответственность", "Вы несете личную ответственность за всё, что отправляете в публичные и приватные чаты."),
                      _buildRuleItem("4", "Администрация", "Администрация при некоторых обстоятельствах может зайти на ваш аккаунт а так же передать его доверенным лицам (правоохранительные органы и т.д.)."),
                      _buildRuleItem("5", "Пароль", "При потере пароля доверенный круг лиц администрации может получить свой логин и пароль по средствам просьбы."),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomBorderButton(
                        text: "Принять",
                        onTap: () {
                          BSavedData.AcceptedTerms.set(true);
                          context.go('/registrarScreen');
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomBorderButton(
                        text: "Отклонить",
                        onTap: () {
                          exit(0);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleItem(String number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: BColors.gray),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(color: BColors.purple, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}