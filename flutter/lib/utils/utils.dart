import 'package:flutter/material.dart';

class Utils {
  static Future<bool> showNotificationToUser(BuildContext context, String message, {String title = 'Error'}) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    ) ?? true;
  }

  static String setFormattedTimeOfDay(TimeOfDay picked) {
   return "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
  }
}
