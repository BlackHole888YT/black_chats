import 'package:black_chats/data/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuestionPage extends StatefulWidget {
  final String title;
  final String description;

  const QuestionPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<StatefulWidget> createState() => _QuestionPage();
}

class _QuestionPage extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BColors.mainColor,
      // ЗАСТАВЛЯЕТ ТЕКСТ ЛЕЗТЬ ПОД АППБАР:
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: BColors.gray.withOpacity(0.6), // полупрозрачный
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          widget.title,
          style: TextStyle(
            color: BColors.textColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: BColors.textColor),
          onPressed: () {
            context.pop();
          },
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 16,
          bottom: 40,
        ),
        child: Text(
          widget.description,
          style: TextStyle(
            color: BColors.gray, // твой фирменный серый
            fontSize: 20,
            height: 1.5, // приятное расстояние между строками
          ),
        ),
      ),
    );
  }
}