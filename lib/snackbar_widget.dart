import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 18.0,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
      backgroundColor: Colors.indigo,
      padding: const EdgeInsets.all(21.0),
      dismissDirection: DismissDirection.down,
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 64.0),
    ),
  );
}

SnackBar promptSnack({required String message,
  required bool isErrorType,
  required bool canBeDismiss}) {
  return SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    behavior: SnackBarBehavior.fixed,
    elevation: 18.0,
    duration: canBeDismiss ? const Duration(seconds: 2) : const Duration(minutes: 5),
    backgroundColor: isErrorType
        ? Colors.redAccent
        : Colors.indigo,
    dismissDirection: DismissDirection.none,
  );
}

