import 'package:intl/intl.dart';
import 'package:mumbi_app/Constant/Variable.dart';

class DateTimeConvert{

  static String calculateChildAge(String birthday) {
    try{
      DateTime now = DateTime.now();
      DateTime dob = DateFormat("yyyy-MM-dd").parse(birthday.split('/').reversed.join("-"));
      String month = ((now.difference(dob).inDays / 30).floor()).toString();
      String dayOfMonth = (((((now.difference(dob).inDays / 30))
          - (now.difference(dob).inDays / 30).floor()) * 30)).floor().toString();
      if(month == "0"){
        return "$dayOfMonth ngày tuổi";
      }else{
        return "$month tháng $dayOfMonth ngày tuổi";
      }
    }catch(e){
      return "...";
    }
  }

  static num calculateChildWeekAge(String birthday) {
    try{
      DateTime now = DateTime.now();
      DateTime dob = DateFormat("yyyy-MM-dd").parse(birthday.split('/').reversed.join("-"));
      num week = ((now.difference(dob).inDays / 7).floor());
      return week;
    }catch(e){
      return 0;
    }
  }

  static String pregnancyWeekAndDay(String estimatedDoB) {
    try{
      DateTime now = DateTime.now();
      DateTime eDob = DateFormat("yyyy-MM-dd").parse(estimatedDoB.split('/').reversed.join("-"));
      String week = (PREGNANCY_WEEK - (eDob.difference(now).inDays / 7).floor()).toString();
      String dayOfWeek = (((PREGNANCY_WEEK - (eDob.difference(now).inDays / 7))
          - (PREGNANCY_WEEK - (eDob.difference(now).inDays / 7)).floor()) * 7).floor().toString();
      if(week == "0"){
        return "$dayOfWeek ngày tuổi";
      }else{
        return "$week tuần $dayOfWeek ngày tuổi";
      }
    }catch(e){
      return "...";
    }
  }


  static num pregnancyWeek(String estimatedDoB) {
    try{
      DateTime now = DateTime.now();
      DateTime eDob = DateFormat("yyyy-MM-dd").parse(estimatedDoB.split('/').reversed.join("-"));
      num week = (eDob.difference(now).inDays / 7).round();
      return PREGNANCY_WEEK - week;
    }catch(e){
      return 0;
    }
  }


  static num dayUntil(String estimatedDoB) {
    try{
      DateTime now = DateTime.now();
      DateTime dob = DateFormat("yyyy-MM-dd").parse(estimatedDoB.split('/').reversed.join("-"));
      String day = (dob.difference(now).inDays).toString();
      return num.parse(day);
    }catch(e){
      return 0;
    }
  }

  static String getCurrentDay(){
    DateTime now = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(now);
  }

  static String getCurrentMonth(){
    DateTime now = DateTime.now();
    return DateFormat('M').format(now);
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

  static DateTime convertStringToDatetimeDMY(String value){
    DateTime date = DateFormat('dd/MM/yyyy').parse(value);
    return date;
  }

  static String convertDateTimeToStringDMY(DateTime value){
    DateTime date = DateTime.parse(value.toString());
    String date2 = "${date.day}/${date.month}/${date.year}";
    return date2;
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
    } else if (difference.inSeconds >= 2) {
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