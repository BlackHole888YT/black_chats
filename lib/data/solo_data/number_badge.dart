import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../colors.dart';
import 'language_converter.dart';

class NumberBadge extends StatefulWidget {
  final int count;
  final double fontSize;

  const NumberBadge({
    super.key,
    required this.count,
    this.fontSize = 30.0,
  });

  @override
  State<NumberBadge> createState() => _NumberBadgeState();
}

class _NumberBadgeState extends State<NumberBadge> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isActive = _isHovered || _isPressed;

    // Разница в толщине бордера: 3.5 - 2.0 = 1.5
    // Вычитаем эту разницу из паддингов, чтобы виджет НЕ ДЁРГАЛСЯ и не смещался вниз!
    final double borderCompensation = isActive ? 1.5 : 0.0;

    // Базовые отступы, масштабируемые под размер шрифта
    final double vPadding = (widget.fontSize * 0.2) - borderCompensation;
    final double hPadding = (widget.fontSize * 0.35) - borderCompensation;

    // Минимальная ширина для идеального круга (для одной цифры)
    final double dynamicMinWidth = widget.fontSize * 1.6;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          context.push('/q', extra: (title: 'Ваш номер - ${widget.count}', description: widget.count == 1? 'Он означает, что вы зарегистрировались в этом приложении ${LanguageConverter.toOrdinal(widget.count)} по счёту. Гордитесь этим, ведь вы админ!' : 'Он означает, что вы зарегистрировались в этом приложении ${LanguageConverter.toOrdinal(widget.count)} по счёту. Гордитесь этим, но номер 1 всегда только у аккаунта админа!'));
        },
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          constraints: BoxConstraints(
            minWidth: dynamicMinWidth, // Автоматический идеальный круг под шрифт 30
          ),
          padding: EdgeInsets.symmetric(
            horizontal: hPadding > 0 ? hPadding : 0,
            vertical: vPadding > 0 ? vPadding : 0,
          ),
          decoration: ShapeDecoration(
            color: Colors.black,
            shape: StadiumBorder(
              side: BorderSide(
                color: isActive ? BColors.purple : BColors.gray,
                width: isActive ? 3.5 : 2.0,
              ),
            ),
          ),
          child: Center(
            widthFactor: 1.0,
            child: Text(
              '${widget.count}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: BColors.textColor,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.bold,
                height: 1.0, // Убирает системные лишние отступы текста
              ),
            ),
          ),
        ),
      ),
    );
  }
}