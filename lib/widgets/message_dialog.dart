import 'package:card_board/constants/strings.dart';
import 'package:flutter/material.dart';

enum DialogAction { cancel, confirm }

class MessageDialog {
  static Future<DialogAction?> show(
    BuildContext context, {
    required String message,
    bool isDestructiveAction = false,
  }) {
    Color primaryColor = const Color(0xFF1e4d61);
    Color secondaryColor = const Color(0xFF2c958f);

    return showDialog<DialogAction>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Center(
            child: Text(
              isDestructiveAction
                  ? AppStrings.confirmation
                  : AppStrings.warning,
              style: TextStyle(
                color: primaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          actions: <Widget>[
            if (isDestructiveAction)
              TextButton(
                child: const Text(
                  AppStrings.cancel,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(DialogAction.cancel);
                },
              ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: secondaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text(AppStrings.confirm),
              onPressed: () {
                Navigator.of(context).pop(DialogAction.confirm);
              },
            ),
          ],
          buttonPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        );
      },
    );
  }
}
