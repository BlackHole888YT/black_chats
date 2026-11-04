import 'package:black_chats/backend/supabase/supabase.dart';
import 'package:black_chats/records/records.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../backend/download_data/download_users_data.dart';
import '../data/solo_data/user_name_converter.dart';
import '../save_data/shared_preferences/shared_preferences.dart';

class BMethods {

  static Future<void> onPressNext(BuildContext context, AuthRecord params)async {
    final user = DownloadUsersData.currentUser;
    await BSavedData.SessionVersion.set(user!.sessionVersion);

    bool isSuccess = false;
    if(params.isRegister == false){
      isSuccess = await BSupaBase.loginUser(login: params.name, password: params.password, context: context);
    }else{
      isSuccess = await BSupaBase.registerUser(name: params.name, password: params.password, context: context);
    }
    if (!isSuccess) return;
    await BSavedData.IsLoggedIn.set(true);
    await BSavedData.UserName.set(params.name);
    await BSavedData.UserLogin.set(UserNameConverter.run(params.name));
    if (context.mounted) {
      context.go("/chats");
    }
  }

  static void onRegisterButtonTap(BuildContext context){
    context.go("/registrarScreen");
  }

  static void onJoinButtonTap(BuildContext context){
    context.go("/joinScreen");
  }

  static void onChatsButtonClick(BuildContext context){
    context.go("/chats");
  }

  static void onPersonButtonClick(BuildContext context){
    context.go("/profile");
  }

  static void onCustomizationButtonClick(BuildContext context){
    context.go("/customization");
  }

  static void onSettingsButtonClick(BuildContext context){
    context.go("/settings");
  }

}