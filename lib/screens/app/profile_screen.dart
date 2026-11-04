import 'dart:io';

import 'package:black_chats/backend/supabase/profile_service.dart';
import 'package:black_chats/bottom_navigation/app_nav_bar.dart';
import 'package:black_chats/bottom_navigation/nav_bar_nums.dart';
import 'package:black_chats/data/colors.dart';
import 'package:black_chats/data/solo_data/bchat.dart';
import 'package:black_chats/data/solo_data/change_password_plate.dart';
import 'package:black_chats/data/solo_data/date_parser.dart';
import 'package:black_chats/data/solo_data/edit_widget.dart';
import 'package:black_chats/data/solo_data/glass_background.dart';
import 'package:black_chats/data/widgets.dart';
import 'package:flutter/material.dart';

import '../../backend/download_data/download_users_data.dart';
import '../../data/solo_data/avatar_picker_square.dart';
import '../../data/solo_data/number_badge.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({
    super.key
  });

  @override
  State<StatefulWidget> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {

  void _showEditNameDialog() {
    final controller = TextEditingController(text: DownloadUsersData.currentUser?.userName);

    showDialog(
      context: context,
      builder: (context) =>
      AlertDialog(
        backgroundColor: BColors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: BColors.purple,
            width: 3.5,
          ),
        ),
        title: Center(child: Text('Сменить имя', style: TextStyle(color: BColors.textColor)),),
        content: TextField(
          controller: controller,
          style: TextStyle(color: BColors.textColor),
          decoration: InputDecoration(
            hintText: 'Новое имя',
            hintStyle: TextStyle(color: BColors.gray),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена', style: TextStyle(color: BColors.textColor)),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await ProfileService.updateUserName(controller.text.trim());
                Navigator.pop(context);
                setState(() {}); // Обновляем экран
              }
            },
            child: Text('Сохранить', style: TextStyle(color: BColors.purple)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = DownloadUsersData.currentUser;

    return GlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: AppNavBar(pageNum: NavBarNumbers.profileScreen),
        appBar: BWidgets.transparentAppBar(
            titleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BChat.getName(fontSize: 32),
                Text(" ", style: TextStyle(fontSize: 32, color: BColors.textColor),),
                Text("- Профиль", style: TextStyle(fontSize: 32, color: BColors.textColor),),
              ],
            )
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Center(
                    child: Column(
                      children: [
                        AvatarPickerSquare(
                          initialImageUrl: user?.avatarUrl,
                          onImageSelected: (File file) async {
                            final newUrl = await ProfileService.uploadAvatar(file);
                            if(newUrl != null){
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: 22,),
                        Row(
                          mainAxisAlignment:  MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              user?.userName ?? 'Загрузка...',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: BColors.textColor
                              ),
                            ),
                            SizedBox(width: 10,),
                            SquareEditButton(cb: ()=> _showEditNameDialog(),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(
                          user?.userLogin != null ? '@${user?.userLogin}' : 'Загрузка...',
                          style: TextStyle(
                              fontSize: 20,
                              color: BColors.textColor
                          ),
                        ),
                        SizedBox(height: 12,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: BColors.mainColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: BColors.outlineUnFocused,
                            ),
                          ),
                          child: Text(
                            "Дата создания аккаунта\n${BDateParser.format(rawDate: user?.createdAt ?? '', mode: BDateMode.dateOnly, context: context,
                            )}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: BColors.textColor, fontWeight: FontWeight.bold, fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: 12,),
                        NumberBadge(count: user?.userId ?? 0,),
                        SizedBox(height: 12,),
                        ChangePasswordPlate(),

                        SizedBox(height: 20,),
                      ],
                    )
                  ),
                ],
              ),
            )
          )
        ),
      )
    );
  }
}