import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(date);

  if (difference.inDays < 1) {
    return 'Today';
  } else if (difference.inDays == 1) {
    return 'Yesterday';
  } else if (difference.inDays <= 7) {
    return '${difference.inDays} days ago';
  } else {
    return DateFormat('dd/MM/yyyy').format(date); // Định dạng ngày tháng
  }
}
