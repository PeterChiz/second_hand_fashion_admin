import 'package:flutter/material.dart';

class SHFDialogs {
  static defaultDialog({
    required BuildContext context,
    String title = 'Xác nhận xóa',
    String content = 'Xóa dữ liệu này sẽ xóa tất cả dữ liệu liên quan. Bạn có chắc không?',
    String cancelText = 'Hủy',
    String confirmText = 'Xóa',
    Function()? onCancel,
    Function()? onConfirm,
  }) {
    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: onConfirm,
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}
