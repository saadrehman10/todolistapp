import 'package:flutter/material.dart';

class Loading {
  static void loadingTemplateOne(BuildContext context, {String? textToDisplay}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(textToDisplay ?? 'Please Wait'),
            ],
          ),
        ),
      ),
    );
  }
}
