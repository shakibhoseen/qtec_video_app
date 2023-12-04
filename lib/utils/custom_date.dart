import 'package:intl/intl.dart';

class CustomDate{
  static String convertDate(DateTime inputDate) {
    // Parse input string to DateTime object
    //DateTime inputDate = DateTime.parse(dateStr);

    // Calculate time difference between current time and input date
    Duration timeDifference = DateTime.now().difference(inputDate);

    if (timeDifference.inMinutes < 60) {
      // If the difference is less than 1 hour, show minutes
      return '${timeDifference.inMinutes} minutes ago';
    } else if (timeDifference.inHours < 24) {
      // If the difference is less than 1 day, show hours
      return '${timeDifference.inHours} hours ago';
    } else if (timeDifference.inDays < 7) {
      // If the difference is less than 7 days, show days
      return '${timeDifference.inDays} days ago';
    } else {
      // Convert to the specified format for differences more than 7 days
      return DateFormat('MMM dd, yyyy').format(inputDate);
    }
  }
}