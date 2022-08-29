import 'package:flutter/material.dart';

class Helper {
  /// error catcher
  static dynamic catchError(
    dynamic exception,
    StackTrace? stackTrace,
  ) {
    debugPrint('Error:\n${exception.toString()}');
    debugPrint('StackTrace:\n${stackTrace.toString()}');
  }
}
