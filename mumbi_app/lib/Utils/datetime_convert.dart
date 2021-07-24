import 'package:intl/intl.dart';

class DateTimeConvert{

  static String calculateAge(String birthday) {
    DateTime now = DateTime.now();
    DateTime dob = DateFormat("yyyy-MM-dd").parse(birthday.split('/').reversed.join("-"));
    String month = ((now.difference(dob).inDays / 30).round()).toString();
    String dayOfMonth = (((((now.difference(dob).inDays / 30)) - (now.difference(dob).inDays / 30).round()) * 30)).round().toString();
    if(month == "0"){
      return "Bé đã $dayOfMonth ngày tuổi";
    }else{
      return "Bé đã $month tháng $dayOfMonth ngày tuổi";
    }
  }

  static String dayUntil(String estimatedDoB) {
    DateTime now = DateTime.now();
    DateTime dob = DateFormat("yyyy-MM-dd").parse(estimatedDoB.split('/').reversed.join("-"));
    String day = (dob.difference(now).inDays).toString();
    return "Bạn còn ${day} ngày nữa để được gặp bé";
  }

  static String getCurrentDay(){
    DateTime now = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(now);
  }

  static String getDayOfWeek(String date){
    date = (DateFormat('EEEE').format(DateTime.parse(date)));
    switch (date){
      case 'Monday': return "Thứ hai"; break;
      case 'Tuesday': return "Thứ ba"; break;
      case 'Wednesday': return "Thứ tư"; break;
      case 'Thursday': return "Thứ năm"; break;
      case 'Friday': return "Thứ sáu"; break;
      case 'Saturday': return "Thứ bảy"; break;
      case 'Sunday': return "Chủ nhật"; break;
      default: return "";
    }
  }

  static String convertDatetimeDMY(String date){
    date = DateFormat('d/M/yyyy').format(DateTime.parse(date));
    return date;
  }

  static String convertDatetimeFullFormat(String date){
    date = DateFormat(', d/M/yyyy H:mm').format(DateTime.parse(date));
    return date;
  }

  static String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(DateTime.parse(dateString));

    DateTime date = DateTime.parse(dateString);
    String dateOfMonth = DateFormat('d').format(date);
    String month = DateFormat('M').format(date);
    String year = DateFormat('yyyy').format(date);
    String time = DateFormat('H:mm').format(date);

    if (difference.inDays > 1){
      return '${dateOfMonth} tháng ${month}, ${year} ${time}';
    } else if (difference.inDays == 1) {
      return 'Hôm qua lúc ${time}';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inSeconds == 3 || difference.inSeconds == 10 || difference.inSeconds == 30) {
      return '${difference.inSeconds} giây trước';
    } else {
      return 'Vừa xong';
    }
  }

  static String timeAgoSinceDateWithDoW(String dateString, {bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(DateTime.parse(dateString));

    DateTime date = DateTime.parse(dateString);
    String dateOfWeek = getDayOfWeek(dateString);
    String dateOfMonth = DateFormat('d').format(date);
    String month = DateFormat('M').format(date);
    String year = DateFormat('yyyy').format(date);
    String time = DateFormat('H:mm').format(date);

    if (difference.inDays > 1){
      return '${dateOfWeek}, ${dateOfMonth} tháng ${month}, ${year} ${time}';
    } else if (difference.inDays == 1) {
      return 'Hôm qua lúc ${time}';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inSeconds >= 2) {
      return '${difference.inSeconds} giây trước';
    } else {
      return 'Vừa xong';
    }
  }

}