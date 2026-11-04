import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/colors.dart';
import 'app_image_cropper.dart';

class AvatarPickerSquare extends StatefulWidget {
  final Function(File croppedFile) onImageSelected; // отдает готовый файл
  final String? initialImageUrl; // если уже есть аватарка

  const AvatarPickerSquare({
    super.key,
    required this.onImageSelected,
    this.initialImageUrl,
  });

  @override
  State<AvatarPickerSquare> createState() => _AvatarPickerSquareState();
}

class _AvatarPickerSquareState extends State<AvatarPickerSquare> {
  File? _imageFile;
  bool _isHovered = false;
  bool _isPressed = false;

  final ImagePicker _picker = ImagePicker();
  bool _isPicking = false;

  Future<void> _pickAndCropImage() async {
    if (_isPicking) return;
    setState(() => _isPicking = true);

    try {
      // 1. Выбираем фото из галереи / проводника (на ПК не ставим крошечный 128px, чтобы не мылить)
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        requestFullMetadata: false, // чтобы не зависало
      );

      if (pickedFile == null) return;

      final File rawFile = File(pickedFile.path);

      // 2. Открываем наш новый кроппер (работает и на ПК, и на мобилках!):
      if (!mounted) return;
      final File? croppedFile = await AppImageCropper.crop(context, rawFile);

      if (croppedFile != null) {
        setState(() {
          _imageFile = croppedFile;
        });
        // Отдаем наружу в профиль для отправки в Supabase:
        widget.onImageSelected(croppedFile);
      }
    } catch (e) {
      print("Ошибка при выборе фото: $e");
    } finally {
      if (mounted) {
        setState(() => _isPicking = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isHighlighted = _isHovered || _isPressed;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _pickAndCropImage();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          width: 160,
          height: 160,
          // 1. Фон под картинкой:
          decoration: BoxDecoration(
            color: BColors.mainColor,
            borderRadius: BorderRadius.circular(20),
          ),
          // 2. ВОТ ОНО: рамка рисуется ПОВЕРХ контента, картинка внутри НЕ ПРЫГАЕТ!
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHighlighted ? BColors.outlineFocused : BColors.outlineUnFocused,
              width: isHighlighted ? 3.5 : 2.0,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    // 1. Если только что выбрали и обрезали новое фото:
    if (_imageFile != null) {
      return Image.file(_imageFile!, fit: BoxFit.cover);
    }

    // 2. Если уже есть аватарка из базы Supabase:
    if (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty) {
      return Image.network(
        widget.initialImageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              color: BColors.purple,
              strokeWidth: 2,
            ),
          );
        },
      );
    }

    // 3. Если фото нет совсем — рисуем иконку:
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.add_a_photo_outlined,
        color: BColors.gray,
        size: 64,
      ),
    );
  }
}