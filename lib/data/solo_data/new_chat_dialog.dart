import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../backend/download_data/download_users_data.dart';
import '../../data/colors.dart';
import '../../data/solo_data/question_widget.dart';
import '../../save_data/isar/local_user_model.dart';
import '../../save_data/isar/main/isar_service.dart';

/// Диалоговое окно поиска и создания нового чата
class NewChatDialog extends StatefulWidget {
  const NewChatDialog({super.key});

  @override
  State<NewChatDialog> createState() => _NewChatDialogState();
}

class _NewChatDialogState extends State<NewChatDialog> {
  /// Исходный список пользователей из базы Isar
  List<LocalUser> _allUsers = [];

  /// Отфильтрованный список пользователей для отображения
  List<LocalUser> _filteredUsers = [];

  /// Флаг первичной загрузки данных
  bool _isLoading = true;

  /// Контроллер поля поискового запроса
  final TextEditingController _searchController = TextEditingController();

  /// Фокус поля поиска для смены цвета обводки и иконки
  final FocusNode _searchFocusNode = FocusNode();

  /// Переключатель скрытия пользователей с закрытым чатом
  bool _hideClosedChats = false;

  /// Состояния наведения и нажатия на крестик
  bool _isCloseHovered = false;
  bool _isClosePressed = false;

  /// Состояние наведения на область диалога
  bool _isDialogHovered = false;

  @override
  void initState() {
    super.initState();
    _loadUsersFromIsar();
    _searchFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  /// Загрузка всех пользователей из локальной базы Isar кроме себя
  Future<void> _loadUsersFromIsar() async {
    final currentUserId = DownloadUsersData.currentUser?.id;
    final users = await IsarService.isar.localUsers.where().findAll();

    final others = users.where((u) => u.id != currentUserId).toList();

    if (mounted) {
      setState(() {
        _allUsers = others;
        _applyFilters();
        _isLoading = false;
      });
    }
  }

  /// Фильтрация: поиск строго по чистому логину и числу ID
  void _applyFilters() {
    final cleanQuery = _searchController.text.trim().toLowerCase();
    final int? searchId = int.tryParse(cleanQuery); // Парсим в int, если ввели число

    setState(() {
      _filteredUsers = _allUsers.where((user) {
        final bool isClosedChat = false;

        if (_hideClosedChats && isClosedChat) {
          return false;
        }

        if (cleanQuery.isNotEmpty) {
          // Чистый логин без собак:
          final bool loginMatch = user.userLogin.toLowerCase().contains(cleanQuery);

          // Точное совпадение по числовому ID:
          final bool idMatch = searchId != null && user.id == searchId;

          return loginMatch || idMatch;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Параметры интерактивного бордера окна
    final double dialogBorderWidth = _isDialogHovered ? 3.5 : 2.0;
    final Color dialogBorderColor = _isDialogHovered ? BColors.outlineFocused : BColors.outlineUnFocused;

    /// Динамический цвет подсветки поиска при активном фокусе
    final bool isSearchFocused = _searchFocusNode.hasFocus;
    final Color searchAccentColor = isSearchFocused ? BColors.purple : BColors.gray;

    /// Цвет кнопки закрытия в зависимости от наведения и нажатия
    final bool isCloseActive = _isCloseHovered || _isClosePressed;
    final Color closeColor = isCloseActive ? BColors.purple : BColors.gray;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isDialogHovered = true),
        onExit: (_) => setState(() => _isDialogHovered = false),
        child: Container(
          width: 500,
          height: 600,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: BColors.mainColor,
            borderRadius: BorderRadius.circular(16),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: dialogBorderColor,
              width: dialogBorderWidth,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Шапка окна с заголовком и интерактивным крестиком
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Новый чат',
                    style: TextStyle(
                      color: BColors.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => setState(() => _isCloseHovered = true),
                    onExit: (_) => setState(() => _isCloseHovered = false),
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => _isClosePressed = true),
                      onTapUp: (_) {
                        setState(() => _isClosePressed = false);
                        Navigator.of(context).pop();
                      },
                      onTapCancel: () => setState(() => _isClosePressed = false),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(Icons.close_rounded, color: closeColor, size: 24),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              /// Панель поиска по логину/ID с переключателем
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          focusNode: _searchFocusNode,
                          controller: _searchController,
                          style: TextStyle(color: BColors.textColor, fontSize: 15),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 6),
                            hintText: 'Поиск по логину или ID...',
                            hintStyle: TextStyle(
                              color: BColors.textColor.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            prefixIconConstraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                            prefixIcon: Icon(Icons.search_rounded, color: searchAccentColor, size: 20),
                          ),
                          onChanged: (_) => _applyFilters(),
                        ),
                        /// Разделительная линия поля поиска
                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: searchAccentColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// Переключатель скрытия пользователей с закрытым чатом
                  Switch(
                    value: _hideClosedChats,
                    activeColor: BColors.purple,
                    activeTrackColor: BColors.purple.withOpacity(0.3),
                    inactiveThumbColor: BColors.gray,
                    inactiveTrackColor: BColors.mainColor,
                    trackOutlineColor: WidgetStateProperty.resolveWith(
                          (states) => states.contains(WidgetState.selected)
                          ? BColors.purple
                          : BColors.outlineUnFocused,
                    ),
                    onChanged: (val) {
                      setState(() {
                        _hideClosedChats = val;
                        _applyFilters();
                      });
                    },
                  ),
                  const SizedBox(width: 4),

                  /// Справка о работе переключателя
                  SquareQuestionButton(
                    size: 24,
                    data: (
                    title: 'Скрыть недоступных',
                    description: 'При включении полностью убирает из списка тех пользователей, у кого выключена настройка «Общий чат».',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// Список пользователей с анимацией прокрутки
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator(color: BColors.purple))
                    : _filteredUsers.isEmpty
                    ? Center(
                  child: Text(
                    'Пользователи не найдены',
                    style: TextStyle(color: BColors.gray, fontSize: 15),
                  ),
                )
                    : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = _filteredUsers[index];
                    final bool isBlocked = false;

                    return Opacity(
                      opacity: isBlocked ? 0.35 : 1.0,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: BColors.mainColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: BColors.outlineUnFocused, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            /// Аватарка пользователя из сети либо заглушка
                            Container(
                              width: 40,
                              height: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: BColors.outlineUnFocused, width: 1),
                              ),
                              child: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
                                  ? Image.network(
                                user.avatarUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(Icons.person, color: BColors.gray),
                              )
                                  : Icon(Icons.person, color: BColors.gray),
                            ),
                            const SizedBox(width: 12),

                            /// Имя пользователя и уникальный логин
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.userName,
                                    style: TextStyle(
                                      color: BColors.textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '@${user.userLogin}',
                                    style: TextStyle(color: BColors.textColor.withOpacity(0.6), fontSize: 13),
                                  ),
                                ],
                              ),
                            ),

                            /// Индикатор недоступности прямого сообщения
                            if (isBlocked)
                              Icon(Icons.lock_outline_rounded, color: BColors.gray, size: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}