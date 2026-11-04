import 'package:black_chats/methods/b_methods.dart';
import 'package:flutter/material.dart';

import '../data/colors.dart';
import 'nav_bar_nums.dart';

class AppNavBar extends StatelessWidget{
  final int pageNum;
  const AppNavBar({super.key, required this.pageNum});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 65,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: BColors.mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: BColors.purple,
                      width: 2.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.chat,
                          color: pageNum == NavBarNumbers.chatScreen ? BColors.purple: BColors.gray,
                          size: 32,
                        ),
                        onPressed: () {
                          BMethods.onChatsButtonClick(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.palette,
                          color: pageNum == NavBarNumbers.customizationScreen ? BColors.purple: BColors.gray,
                          size: 32,
                        ),
                        onPressed: () {
                          BMethods.onCustomizationButtonClick(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.tune,
                          color: pageNum == NavBarNumbers.settingsScreen ? BColors.purple: BColors.gray,
                          size: 32,
                        ),
                        onPressed: () {
                          BMethods.onSettingsButtonClick(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.person_outline_rounded,
                          color: pageNum == NavBarNumbers.profileScreen ? BColors.purple: BColors.gray,
                          size: 32,
                        ),
                        onPressed: () {
                          BMethods.onPersonButtonClick(context);
                        },
                      ),
                    ],
                  )
              )
            )
          ],
        ),
      ),
    );
  }
}