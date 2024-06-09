import 'package:timeago/timeago.dart' as timeago;

extension StringExtention on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension DateTimeExtention on DateTime {
  String timeAgo() {
    timeago.setLocaleMessages('id', timeago.IdMessages());
    return timeago.format(this, locale: 'id').capitalize();
  }
}
