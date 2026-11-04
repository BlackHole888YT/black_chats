import 'package:flutter/material.dart';

import '../../bottom_navigation/app_nav_bar.dart';
import '../../bottom_navigation/nav_bar_nums.dart';
import '../../data/colors.dart';
import '../../data/solo_data/bchat.dart';
import '../../data/solo_data/glass_background.dart';
import '../../data/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: AppNavBar(pageNum: NavBarNumbers.settingsScreen),
          appBar: BWidgets.transparentAppBar(
              titleWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BChat.getName(fontSize: 32),
                  Text(" ", style: TextStyle(fontSize: 32, color: BColors.textColor),),
                  Text("- Настройки", style: TextStyle(fontSize: 32, color: BColors.textColor),),
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
                  ],
                ),
              )
            ),
          )
        ),
      ),
    );
  }
}