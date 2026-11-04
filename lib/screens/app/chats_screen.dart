import 'package:black_chats/data/solo_data/question_widget.dart';
import 'package:flutter/material.dart';

import '../../bottom_navigation/app_nav_bar.dart';
import '../../bottom_navigation/nav_bar_nums.dart';
import '../../data/colors.dart';
import '../../data/solo_data/b_scroll_container.dart';
import '../../data/solo_data/bchat.dart';
import '../../data/solo_data/floating_add_chat_button.dart';
import '../../data/solo_data/glass_background.dart';
import '../../data/solo_data/new_chat_dialog.dart';
import '../../data/widgets.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: AppNavBar(pageNum: NavBarNumbers.chatScreen),
          appBar: BWidgets.transparentAppBar(
              titleWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BChat.getName(fontSize: 32),
                  Text(" ", style: TextStyle(fontSize: 32, color: BColors.textColor),),
                  Text("- Чаты", style: TextStyle(fontSize: 32, color: BColors.textColor),),
                ],
              )
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(right: 20),
            child: FloatingAddChatButton(
              onTap: () {
                /// Логика экрана наложения (экран не на весь экран)
                showDialog(
                  context: context,
                  builder: (context) => const NewChatDialog(),
                );
              },
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20,),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  BScrollContainer(
                    padding: EdgeInsetsGeometry.only(top: 6, bottom: 12, left: 15, right: 15),
                    width: double.infinity,
                    borderRadius: 14,
                    onTap: () {
                      null;
                      /// Пустая логика, т.к. он содержит все чаты пользователя
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Сортировка чатов", style: TextStyle(color: BColors.textColor, fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(width: 10,),
                            SquareQuestionButton(size: 24, data: (title: 'Сортировка чатов', description: 'Нажав на кнопки ниже, вы сможете сортировать ваши чаты.\nВсе - все ваши чаты\nИзбранные - все ваши избранные чаты (с активной (жёлтой) звездой)\nГрупповые - все ваши групповые чаты, состоящие из 3-ёх и более человек\nЛичные - ваши личные чаты, состоящие только из вас и вашего собеседника\nЛюбовные - чаты с активным(розовым) сердцем - вы можете пометить этим тех, кого вы любите (например ваших родителей, вашего партнёра, ваших братьев/сестёр, вы уж найдёте кому "отдать ваше сердце"\n\nПрокрутка - список из этих чатов листается вправо.\nНа телефоне - проведите пальцем в нужную сторону.\nНа пк - зажмите Shift и прокрутите колёсиком мыши: вниз - список листается влево, вверх - листается вправо)'))
                          ],
                        ),
                        SizedBox(height: 8,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              BScrollContainer(
                                padding:  EdgeInsetsGeometry.all(8),
                                borderRadius: 6,
                                onTap: () {  },
                                child: Column(
                                  children: [
                                    Text("Все", style: TextStyle(color: BColors.textColor, fontSize: 15, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              BScrollContainer(
                                padding:  EdgeInsetsGeometry.all(8),
                                borderRadius: 6,
                                onTap: () {  },
                                child: Column(
                                  children: [
                                    Text("Избранные", style: TextStyle(color: BColors.textColor, fontSize: 15, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              BScrollContainer(
                                padding:  EdgeInsetsGeometry.all(8),
                                borderRadius: 6,
                                onTap: () {  },
                                child: Column(
                                  children: [
                                    Text("Групповые", style: TextStyle(color: BColors.textColor, fontSize: 15, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              BScrollContainer(
                                padding:  EdgeInsetsGeometry.all(8),
                                borderRadius: 6,
                                onTap: () {  },
                                child: Column(
                                  children: [
                                    Text("Личные", style: TextStyle(color: BColors.textColor, fontSize: 15, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              BScrollContainer(
                                padding: EdgeInsetsGeometry.all(8),
                                borderRadius: 6,
                                onTap: () {  },
                                child: Column(
                                  children: [
                                    Text("Любовные", style: TextStyle(color: BColors.textColor, fontSize: 15, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: BScrollContainer(
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: 14,
                      onTap: () {
                        null;
                        /// Пустая логика, т.к. он содержит все чаты пользователя
                      },
                      child: Column(
                        children: [
                          Text("Элемент 1", style: TextStyle(color: BColors.textColor)),
                          Text("Элемент 2", style: TextStyle(color: BColors.textColor)),
                        ],
                      ),
                    ),
                  )
                ]
              )
            ),
          )
        ),
      ),
    );
  }
}