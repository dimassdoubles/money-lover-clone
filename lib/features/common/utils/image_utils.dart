import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_lover_clone/features/common/common.dart';

class ImageUtils {
  const ImageUtils._();

  static void pickImage(
    BuildContext context, {
    bool openCamera = true,
    void Function(XFile? selectedImage)? onSelectedImage,
  }) async {
    try {
      ShowUtils.showLoading();
      final ImagePicker picker = ImagePicker();
      final result = await picker.pickImage(
        source: openCamera ? ImageSource.camera : ImageSource.gallery,
      );

      ShowUtils.dismissLoading();
      if (result != null) {
        onSelectedImage?.call(result);
      } else {
        ShowUtils.showError("Tidak ada gambar yang terpilih");
      }
    } catch (e) {
      ShowUtils.showError("$e");
    }
  }
}
