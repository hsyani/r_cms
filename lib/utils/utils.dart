// /lib/utils/utils.dart
import 'package:intl/intl.dart';

String getFormattedCurrentDateTime() {
  return DateFormat('yyyy년 MM월 dd일 HH:mm').format(DateTime.now());
}

String getFormattedCurrentDate() {
  return DateFormat('yyyy년 MM월 dd일').format(DateTime.now());
}

String getFormattedCurrentTime() {
  return DateFormat('HH:mm').format(DateTime.now());
}
