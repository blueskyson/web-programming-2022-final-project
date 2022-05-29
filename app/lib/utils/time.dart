import 'package:intl/intl.dart';

String getCurrentTime() {
  return DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
}
