import 'package:intl/intl.dart';

class DateHelper {
  static String laravelDateToFormattedDate(String laravelDate) {
    // Parse the Laravel date string to a DateTime object
    DateTime date = DateTime.parse(laravelDate);

    // Define the date format you want
    String formattedDate = DateFormat('d MMM y').format(date);

    return formattedDate;
  }

  static String convertLaravelDateFormatToDayMonthYearDateFormat(
      String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('d MMM y').format(dateTime);
    return formattedDate;
  }

  static String convertDateFormatToDayMonthYearDateFormat(String inputDate) {
    DateTime parsedDate = DateTime.parse(inputDate);
    String formattedDate = DateFormat("MMM, d, yyyy").format(parsedDate);
    return formattedDate;
  }

  static String Hour12formatTime(String inputTime) {
    try {
      // Parse the input time string
      DateTime dateTime = DateFormat("HH:mm:ss").parse(inputTime);

      // Format the time in 12-hour format with AM/PM
      String formattedTime = DateFormat("h:mm a").format(dateTime);

      return formattedTime;
    } catch (e) {
      // Handle parsing errors, e.g., invalid time format
      return "N/A";
    }
  }

  static String unixTimestampTo12HourTime(int unixTimestamp) {
    // Convert Unix timestamp to DateTime
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);

    // Format the DateTime to 12-hour time format
    String formattedTime = DateFormat.jm().format(dateTime);

    return formattedTime;
  }

  static int getCurrentUTCTimestamp() {
    final DateTime now = DateTime.now().toUtc();
    return now.millisecondsSinceEpoch ~/ 1000; // Convert to seconds
  }

  static String convertDateFormat(String originalDate) {
    DateTime dateTime = DateTime.parse(originalDate).add(Duration(hours: 5));
    DateFormat dateFormat = DateFormat.yMMMMd('en_US');
    return dateFormat.format(dateTime);
  }

  static String convertTo12HourFormatFromTimeStamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp).add(Duration(hours: 5));
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  static String convert24HourFormatTo12HourTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("hh:mm:ss a").format(parsedTime);
    return formattedTime;
  }

  static String formatTimeToAMPM(String time) {
    // Parse the input time string to create a DateTime object
    DateTime parsedTime = DateFormat('HH:mm').parse(time);

    // Format the DateTime object to include AM/PM
    String formattedTime = DateFormat('h:mm a').format(parsedTime);

    return formattedTime;
  }

  static String convertServerTimestampToLocalTime(
      int serverTimestampInSeconds) {
    DateTime serverDateTime =
        DateTime.fromMillisecondsSinceEpoch(serverTimestampInSeconds * 1000);
    DateTime localDateTime = serverDateTime.toLocal();
    String formattedTime = DateFormat('h:mm a').format(localDateTime);
    return formattedTime;
  }

  static String convertTimestampDayMonth(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateFormat formatter = DateFormat('d MMM');
    return formatter.format(dateTime);
  }

  static String formatDate(String date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');

    DateTime myDate = DateTime.parse(date);
    formatter.format(myDate);
    var formattedDate = myDate.toString().split(' ')[0];

    return formattedDate;
  }

  static String getFormattedTime({required String time}) {
    int hour = int.parse(time.split(':')[0].toString());
    String hourZero = '';

    String minute = '00';

    String isAmOrPm = 'AM';

    if (hour > 12) {
      hour = hour - 12;
      isAmOrPm = 'PM';
    } else if (hour == 00) {
      hour = 12;
    } else if (hour == 12) {
      isAmOrPm = 'PM';
    }

    if (minute == '0') {
      minute = '00';
    }

    if (hour < 10) {
      hourZero = '0';
    }

    return '${hourZero.toString()}${hour.toString()}:${minute.toString()} $isAmOrPm';
  }

  static String getFormattedTime2({required String time}) {
    int hour = int.parse(time.split(':')[0].toString());
    String hourZero = '';

    String minute = time.split(':')[1].toString();

    String isAmOrPm = 'AM';

    if (hour > 12) {
      hour = hour - 12;
      isAmOrPm = 'PM';
    } else if (hour == 00) {
      hour = 12;
    } else if (hour == 12) {
      isAmOrPm = 'PM';
    }

    if (minute == '0') {
      minute = '00';
    }

    if (hour < 10) {
      hourZero = '0';
    }

    return '${hourZero.toString()}${hour.toString()}:${minute.toString()}:00 $isAmOrPm';
  }

  // for chat app
  static DateTime returnDateAndTimeFormat(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    var originalDate = DateFormat('MM/dd/yyyy').format(dt);
    return DateTime(dt.year, dt.month, dt.day);
  }

  //function to return message time in 24 hours format AM/PM
  static String messageTime(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    String difference = '';
    difference = DateFormat('jm').format(dt).toString();
    return difference;
  }

  // function to return date if date changes based on your local date and time
  static String groupMessageDateAndTime(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    var originalDate = DateFormat('MM/dd/yyyy').format(dt);

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String difference = '';
    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      difference = "Today";
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else {
      difference = DateFormat.yMMMd().format(dt).toString();
    }

    return difference;
  }
}
