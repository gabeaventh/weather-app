import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatToFullTitle() {
    DateFormat format = DateFormat('EEE, MMM d, yyyy hh:mm aaa');

    return format.format(this);
  }

  String formatToShortTitle() {
    DateFormat format = DateFormat('EEEE, MMMM d, yyyy');

    return format.format(this);
  }

  String formatToShortTime() {
    DateFormat format = DateFormat('hh:mm aaa');

    return format.format(this);
  }
}
