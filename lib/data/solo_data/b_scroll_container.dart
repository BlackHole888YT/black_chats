import 'package:flutter/material.dart';
import '../../data/colors.dart'; // путь к твоим BColors

class BScrollContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const BScrollContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 14.0, // Небольшое, но хорошо заметное скругление
    this.padding = const EdgeInsets.all(12),
    this.onTap,
  });

  @override
  State<BScrollContainer> createState() => _BScrollContainerState();
}

class _BScrollContainerState extends State<BScrollContainer> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isActive = _isHovered || _isPressed;

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap?.call();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          width: widget.width,
          height: widget.height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: isActive ? BColors.outlineFocused : BColors.outlineUnFocused,
              width: isActive ? 3.5 : 2.0,
            ),
          ),
          child: SingleChildScrollView(
            padding: widget.padding,
            physics: const BouncingScrollPhysics(),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}