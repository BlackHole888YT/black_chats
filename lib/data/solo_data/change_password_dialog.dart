import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../backend/download_data/download_users_data.dart';
import '../../data/colors.dart';
import '../../save_data/shared_preferences/shared_preferences.dart';
import 'bbutton.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  int _currentStep = 1;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  // FocusNode следит, активно ли поле ввода прямо сейчас:
  final FocusNode _fieldFocusNode = FocusNode();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Слушаем фокус, чтобы перекрашивать рамку всего диалога в реальном времени:
    _fieldFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _fieldFocusNode.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  // ШАГ 1: Проверка старого пароля
  Future<void> _verifyOldPassword() async {
    final user = DownloadUsersData.currentUser;
    if (user == null) return;

    final oldPassword = _currentPasswordController.text.trim();
    if (oldPassword.isEmpty) {
      setState(() => _errorMessage = 'Введите текущий пароль');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await Supabase.instance.client
          .from('users')
          .select('user_password')
          .eq('id', user.id)
          .single();

      if (response['user_password'] != oldPassword) {
        setState(() {
          _errorMessage = 'Неверный текущий пароль!';
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _isLoading = false;
        _currentStep = 2;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ошибка связи с сервером: $e';
        _isLoading = false;
      });
    }
  }

  // ШАГ 2: Сохранение нового пароля и выход
  Future<void> _saveNewPasswordAndLogout() async {
    final user = DownloadUsersData.currentUser;
    if (user == null) return;

    final newPassword = _newPasswordController.text.trim();
    if (newPassword.length < 6) {
      setState(() => _errorMessage = 'Пароль должен быть от 6 символов');
      return;
    }

    if (newPassword == _currentPasswordController.text.trim()) {
      setState(() => _errorMessage = 'Новый пароль не должен совпадать со старым');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final int newVersion = user.sessionVersion + 1;

      await Supabase.instance.client.from('users').update({
        'user_password': newPassword,
        'session_version': newVersion,
      }).eq('id', user.id);

      await BSavedData.IsLoggedIn.set(false);
      await BSavedData.SessionVersion.set(newVersion);
      DownloadUsersData.currentUser = null;

      if (!mounted) return;

      context.go('/registrarScreen');

    } catch (e) {
      setState(() {
        _errorMessage = 'Не удалось обновить пароль: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Активно ли поле ввода в данный момент:
    final bool isFieldFocused = _fieldFocusNode.hasFocus;

    return AlertDialog(
      backgroundColor: BColors.mainColor,
      // РАМКА ДИАЛОГА: серая 2.0 в покое, фиолетовая 3.5 при нажатии на поле ввода
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isFieldFocused ? BColors.outlineFocused : BColors.outlineUnFocused,
          width: isFieldFocused ? 3.5 : 2.0,
        ),
      ),
      title: Center(
        child: Text(
          _currentStep == 1 ? 'Подтверждение (1/2)' : 'Новый пароль (2/2)',
          style: TextStyle(
            color: BColors.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentStep == 1
                  ? 'Введите ваш текущий пароль:'
                  : 'Придумайте новый надежный пароль:',
              style: TextStyle(color: BColors.textColor, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),

            // Поле ввода без рамок:
            TextField(
              focusNode: _fieldFocusNode,
              controller: _currentStep == 1
                  ? _currentPasswordController
                  : _newPasswordController,
              obscureText: _currentStep == 1 ? _obscureCurrent : _obscureNew,
              style: TextStyle(color: BColors.textColor, fontSize: 16),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                hintText: _currentStep == 1 ? 'Текущий пароль' : 'Новый пароль',
                hintStyle: TextStyle(color: BColors.textColor.withOpacity(0.5)),
                border: InputBorder.none, // Убираем стандартные рамки инпута
                suffixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    (_currentStep == 1 ? _obscureCurrent : _obscureNew)
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: BColors.gray,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_currentStep == 1) {
                        _obscureCurrent = !_obscureCurrent;
                      } else {
                        _obscureNew = !_obscureNew;
                      }
                    });
                  },
                ),
              ),
            ),

            // 👇 ПОЛОСКА ШИРИНОЙ 1 ПИКСЕЛЬ ЦВЕТА TEXTCOLOR ПОД ТЕКСТОМ:
            Container(
              height: 1.0,
              width: double.infinity,
              color: BColors.textColor,
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: TextStyle(color: BColors.textColor, fontSize: 13),
              ),
            ],
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Кнопка «Отмена»
            BButton(
              text: 'Отмена',
              onTap: _isLoading ? null : () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 10),

            // Кнопка «Далее» / «Сменить»
            BButton(
              text: _currentStep == 1 ? 'Далее' : 'Сменить',
              isLoading: _isLoading,
              onTap: () {
                if (_currentStep == 1) {
                  _verifyOldPassword();
                } else {
                  _saveNewPasswordAndLogout();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}