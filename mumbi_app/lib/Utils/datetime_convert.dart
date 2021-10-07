import 'package:intl/intl.dart';
import 'package:mumbi_app/Constant/Variable.dart';

class DateTimeConvert {
  static String calculateChildAge(String birthday) {
    try {
      DateTime now = DateTime.now();
      DateTime dob = DateFormat("yyyy-MM-dd").parse(birthday.split('/').reversed.join("-"));

      num years = now.year - dob.year;
      num months = now.month - dob.month;
      num days = now.day - dob.day;

      if(days < 0){
        final monthAgo = new DateTime(now.year, now.month - 1, dob.day);
        days = now.difference(monthAgo).inDays;
        months--;
      }

      months += years * 12;

      return "${months} tháng ${days} ngày";

    } catch (e) {
      return "...";
    }
  }

  static num calculateChildWeekAge(String birthday) {
    try {
      DateTime now = DateTime.now();
      DateTime dob = DateFormat("yyyy-MM-dd")
          .parse(birthday.split('/').reversed.join("-"));
      num week = ((now.difference(dob).inDays / 7).floor());
      return week;
    } catch (e) {
      return 0;
    }
  }

  static String pregnancyWeekAndDay(String estimatedDoB) {
    try {
      DateTime now = DateTime.now();
      DateTime eDob = DateFormat("yyyy-MM-dd").parse(estimatedDoB.split('/').reversed.join("-"));
      String week = (PREGNANCY_WEEK - (eDob.difference(now).inDays / 7).floor()).toString();
      String dayOfWeek = (((PREGNANCY_WEEK - (eDob.difference(now).inDays / 7)) - (PREGNANCY_WEEK - (eDob.difference(now).inDays / 7)).floor()) * 7).floor().toString();
      if (week == "0") {
        return "$dayOfWeek ngày tuổi";
      } else {
        return "$week tuần $dayOfWeek ngày tuổi";
      }
    } catch (e) {
      return "...";
    }
  }

  static num pregnancyWeek(String estimatedDoB) {
    try {
      DateTime now = DateTime.now();
      DateTime eDob = DateFormat("yyyy-MM-dd")
          .parse(estimatedDoB.split('/').reversed.join("-"));
      num week = (eDob.difference(now).inDays / 7).floor();
      return PREGNANCY_WEEK - week;
    } catch (e) {
      return 0;
    }
  }

  static num dayUntil(String estimatedDoB) {
    try {
      DateTime now = DateTime.now();
      DateTime dob = DateFormat("yyyy-MM-dd")
          .parse(estimatedDoB.split('/').reversed.join("-"));
      String day = (dob.difference(now).inDays).toString();
      return num.parse(day);
    } catch (e) {
      return 0;
    }
  }

  static String getCurrentDay() {
    DateTime now = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(now);
  }

  static String getCurrentMonth() {
    DateTime now = DateTime.now();
    return DateFormat('M').format(now);
  }

  static String getDayOfWeek(String date) {
    date = (DateFormat('EEEE').format(DateTime.parse(date)));
    switch (date) {
      case 'Monday':
        return "Thứ hai";
        break;
      case 'Tuesday':
        return "Thứ ba";
        break;
      case 'Wednesday':
        return "Thứ tư";
        break;
      case 'Thursday':
        return "Thứ năm";
        break;
      case 'Friday':
        return "Thứ sáu";
        break;
      case 'Saturday':
        return "Thứ bảy";
        break;
      case 'Sunday':
        return "Chủ nhật";
        break;
      default:
        return "";
    }
  }

  static DateTime convertStringToDatetimeDMY(String value) {
    DateTime date = DateFormat('dd/MM/yyyy').parse(value);
    return date;
  }

  static String convertDateTimeToStringDMY(DateTime value) {
    DateTime date = DateTime.parse(value.toString());
    String date2 = "${date.day}/${date.month}/${date.year}";
    return date2;
  }

  static String getTime(String date) {
    date = DateFormat('H:mm').format(DateTime.parse(date));
    return date;
  }

  static String getDay(String date) {
    date = DateFormat('d').format(DateTime.parse(date));
    return date;
  }

  static String getMonth(String date) {
    date = DateFormat('M').format(DateTime.parse(date));
    return date;
  }

  static String getYear(String date) {
    date = DateFormat('yyyy').format(DateTime.parse(date));
    return date;
  }

  static String convertDatetimeDMY(String date) {
    date = DateFormat('d/M/yyyy').format(DateTime.parse(date));
    return date;
  }

  static String convertDatetimeFullFormat(String date) {
    date = DateFormat('d/M/yyyy H:mm').format(DateTime.parse(date));
    return date;
  }

  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(DateTime.parse(dateString));

    DateTime date = DateTime.parse(dateString);
    String dateOfMonth = DateFormat('d').format(date);
    String month = DateFormat('M').format(date);
    String year = DateFormat('yyyy').format(date);
    String time = DateFormat('H:mm').format(date);

    if (difference.inDays > 1) {
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

  static String timeAgoSinceDateWithDoW(String dateString,
      {bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(DateTime.parse(dateString));

    DateTime date = DateTime.parse(dateString);
    String dateOfWeek = getDayOfWeek(dateString);
    String dateOfMonth = DateFormat('d').format(date);
    String month = DateFormat('M').format(date);
    String year = DateFormat('yyyy').format(date);
    String time = DateFormat('H:mm').format(date);

    if (difference.inDays > 1) {
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

  static String timeAgoInShort(String dateString,
      {bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(DateTime.parse(dateString));

    DateTime date = DateTime.parse(dateString);
    String time = DateFormat('H:mm').format(date);

    if(difference.inDays >= 365){
      return '${(difference.inDays / 365).floor()} tháng trước';
    } else if (difference.inDays >= 30) {
      return '${(difference.inDays / 30).floor()} tháng trước';
    } else if (difference.inDays >= 7) {
      return '${(difference.inDays / 7).floor()} tuần trước';
    } else if (difference.inDays > 1) {
      return '${difference.inDays} ngày trước';
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

  static String calculateToothDate(DateTime birthday) {
    String day;
    try {
      Duration dur = DateTime.now().difference(birthday);
      double durInMoth = dur.inDays / 30;
      double durInDay = dur.inDays / 30 - 12 * dur.inDays / 30 / 12;
      int durDay = (DateTime.now().day - birthday.day);
      print('durDay' + durDay.toString());
      if (durDay < 0) durDay *= -1;
      if (durInDay < 0) durInDay *= -1;
      if (durInMoth < 12 && durInMoth >= 1) {
        day = durInMoth.floor().toString() +
            " tháng " +
            durDay.toString() +
            " ngày";
      } else if (durInMoth > 12) {
        day = (durInMoth / 12).floor().toString() +
            " năm " +
            durInDay.floor().toString() +
            " tháng " +
            durDay.toString() +
            " ngày";
      } else if (durInMoth >= 0) {
        day = dur.inDays.toString() + " ngày";
      } else if (durInMoth < 0) day = "Ngày sai";
      return day;
    } catch (e) {
      return "...";
    }
  }

  static String calculateChildBorn(String datetime) {
    String dayResult;
    try {
      DateTime birthday = DateTime.parse(datetime.split('/').reversed.join());
      Duration dur = DateTime.now().difference(birthday);
      // print('dur'+dur.toString());
      int durInDay = (dur.inDays / 30 - 12 * dur.inDays / 30 / 12).floor();
      int durInMonth = (dur.inDays / 30).floor();
      // print('durInMonth'+durInMonth.toString());
      int durInYear = (durInMonth / 12).floor();
      // print('durInYear'+durInYear.toString());
      // print('durInDay'+durInDay.toString());

      int durDay;
      if (birthday.day >= DateTime.now().day)
        durDay = (DateTime.now().day - birthday.day);
      else
        durDay = birthday.day;
      if (durDay < 0) durDay *= -1;

      int durMonth;
      if (birthday.month >= DateTime.now().month)
        durMonth = (DateTime.now().month - birthday.month);
      else
        durMonth = birthday.month;
      if (durDay < 0) durDay *= -1;
      String year = durInYear.toString();
      String month = durInMonth.toString();
      String monthInYear = durMonth.toString();
      String day = durDay.toString();

      if (durInMonth < 0)
        dayResult = "Ngày sai";
      else if (durInMonth >= 0 && durInMonth < 1) {
        dayResult = dur.inDays.toString() + " ngày";
      } else if (durInMonth < 12 && durInMonth >= 1) {
        dayResult = "$month tháng $day ngày";
      } else if (durInYear >= 1 && durInMonth > 12) {
        dayResult = "$year tuổi $monthInYear tháng $day ngày";
      } else if (durInYear >= 1 && durInMonth <= 12) {
        dayResult = "$year tuổi 0 tháng $day ngày";
      }

      return dayResult;
    } catch (e) {
      return "...";
    }
  }

  static String calculateChildMonth(String monthBaby, DateTime chilDateTime) {
    try {
      DateTime dateTimeBaby = DateFormat("yyyy-MM-dd")
          .parse(monthBaby.split('/').reversed.join("-"));
      int month = ((chilDateTime.difference(dateTimeBaby).inDays / 30).floor());
      if(month < 0)
        month*=-1;
      return month.toString();
    } catch (e) {
      return null;
    }
  }

  static String caculateBMI(num weight, num height) {
    String status;
    num numBMI = weight / ((height/100) * (height/100));
    if (numBMI < 18.5) {
      status = "Thiếu cân";
    } else if (numBMI >= 18.5 && numBMI <= 24.9) {
      status = "Bình thường";
    } else if(numBMI >= 25)
      status = "Thừa cân";
    return status;
  }

  static String caculateBMIdata(num weight, num height) {
    print('weight'+weight.toString());
    print('height'+height.toString());
    num numBMI = weight / ((height/100) * (height/100));
    print('numBMI'+numBMI.toString());
    return numBMI.toStringAsFixed(1);
  }
}
