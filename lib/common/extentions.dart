import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExtention on DateTime {
  String timeAgo() {
    timeago.setLocaleMessages('id', timeago.IdMessages());
    return timeago.format(this, locale: 'id');
  }
}
