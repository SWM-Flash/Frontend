import 'package:intl/intl.dart';

String formatDateString(String dateString) {
  // 문자열을 DateTime 객체로 파싱합니다.
  DateTime dateTime = DateTime.parse(dateString);

  // 연도 형식을 변경합니다.
  String year = DateFormat('yy').format(dateTime);

  // 월과 일을 한국어 형식으로 포맷팅합니다.
  String month = DateFormat('M').format(dateTime);
  String day = DateFormat('d').format(dateTime);

  return '$year년 $month월 $day일';
}