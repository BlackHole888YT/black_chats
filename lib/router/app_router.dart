import 'package:black_chats/methods/b_methods.dart';
import 'package:black_chats/records/records.dart';
import 'package:black_chats/screens/app/chats_screen.dart';
import 'package:black_chats/screens/app/customization_screen.dart';
import 'package:black_chats/screens/app/profile_screen.dart';
import 'package:black_chats/screens/app/settings_screen.dart';
import 'package:black_chats/screens/question_page/question_page.dart';
import 'package:black_chats/screens/registration/join_screen.dart';
import 'package:black_chats/screens/terms_screen/terms_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../screens/registration/registration_screen.dart';

GoRouter createRouter(bool isLogged, bool isAcceptTerms) {
  return GoRouter(
      initialLocation: isAcceptTerms? (isLogged ? '/chats' : '/registrarScreen') : '/acceptTermsScreen',
      routes: [
        GoRoute(
            path: '/registrarScreen',
            pageBuilder: (context, state) =>
                CustomTransitionPage(
                    key: state.pageKey,
                    child: const RegistrationScreen(),
                    transitionDuration: const Duration(milliseconds: 250),
                    transitionsBuilder: (context, animation, secondaryAnimation,
                        child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    }
                )
        ),
        GoRoute(
          path: '/joinScreen',
          pageBuilder: (context, state) =>
            CustomTransitionPage(
              key: state.pageKey,
              child: const JoinScreen(),
              transitionDuration: const Duration(milliseconds: 250),
              transitionsBuilder: (context, animation, secondaryAnimation,
                  child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              }
            )
        ),
        GoRoute(
          path: '/chats',
          builder: (context, state) => ChatsScreen()
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => ProfileScreen()
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => SettingsScreen()
        ),
        GoRoute(
          path: '/customization',
          builder: (context, state) => CustomizationScreen()
        ),
        GoRoute(
          path: '/q',
          builder: (context, state) {
            final QuestionRecord data = state.extra as QuestionRecord;
            return QuestionPage(title: data.title, description: data.description,);
          }
        ),
        GoRoute(
          path: '/acceptTermsScreen',
          builder: (context, state) => TermsScreen()
        ),
      ]
  );
}