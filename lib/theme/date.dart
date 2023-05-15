import 'package:intl/intl.dart'; // Import pustaka intl untuk mengubah format tanggal

class DateUtil {
  static String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE, d MMMM yyyy').format(now);
  }
}

class TimeUtil {
  static String formatTime() {
    DateTime now = DateTime.now();
    return DateFormat('h:mm a').format(now);
  }
}


class TimePlus {
  static String timePlus(int hours) {
    DateTime now = DateTime.now();
    DateTime timeLater = now.add(Duration(hours: hours));
    return DateFormat('h:mm a').format(timeLater);
  }
}


class AddDays {
  static String addDaysToDate(String date, int daysToAdd) {
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    DateTime newDate = parsedDate.add(Duration(days: daysToAdd));
    return DateFormat('EEEE').format(newDate);
  }
}

