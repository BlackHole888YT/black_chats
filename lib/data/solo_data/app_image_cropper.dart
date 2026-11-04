import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

// Подключи свои цвета:
import '../../data/colors.dart'; // проверь правильность пути к BColors

class AppImageCropper {
  /// Главный метод: передаешь исходный File -> получаешь обрезанный квадратный File
  static Future<File?> crop(BuildContext context, File originalFile) async {
    final Uint8List imageBytes = await originalFile.readAsBytes();

    return await showDialog<File?>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _CropDialog(imageBytes: imageBytes),
    );
  }
}

class _CropDialog extends StatefulWidget {
  final Uint8List imageBytes;
  const _CropDialog({required this.imageBytes});

  @override
  State<_CropDialog> createState() => _CropDialogState();
}

class _CropDialogState extends State<_CropDialog> {
  final _cropController = CropController();
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: BColors.mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: BColors.outlineUnFocused, width: 2),
      ),
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        width: 500,
        height: 550,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Кадрирование аватарки',
              style: TextStyle(
                color: BColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Crop(
                  image: widget.imageBytes,
                  controller: _cropController,
                  aspectRatio: 1.0, // Строгий квадрат 1:1 (сам отцентрируется!)
                  interactive: true,
                  baseColor: Colors.black,
                  maskColor: Colors.black.withOpacity(0.7),
                  cornerDotBuilder: (size, edgeAlignment) => const SizedBox.shrink(),

                  onCropped: (CropResult result) async {
                    if (result is CropSuccess) {
                      final codec = await ui.instantiateImageCodec(
                        result.croppedImage,
                        targetWidth: 256,
                        targetHeight: 256,
                      );
                      final frame = await codec.getNextFrame();
                      final byteData = await frame.image.toByteData(format: ui.ImageByteFormat.png);
                      final Uint8List resizedBytes = byteData!.buffer.asUint8List();

                      final tempDir = await getTemporaryDirectory();
                      final file = File('${tempDir.path}/avatar_${DateTime.now().millisecondsSinceEpoch}.png');
                      await file.writeAsBytes(resizedBytes);

                      if (mounted) {
                        Navigator.of(context).pop(file);
                      }
                    } else if (result is CropFailure) {
                      print("Ошибка кадрирования: ${result.cause}");
                      if (mounted) {
                        Navigator.of(context).pop(null);
                      }
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isProcessing ? null : () => Navigator.of(context).pop(null),
                  child: Text('Отмена', style: TextStyle(color: BColors.gray)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BColors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _isProcessing
                      ? null
                      : () {
                    setState(() => _isProcessing = true);
                    _cropController.crop();
                  },
                  child: _isProcessing
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                      : const Text('Применить', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}