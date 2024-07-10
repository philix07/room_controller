import 'package:intl/intl.dart';

class AppFormatter {
  String number(int num) {
    NumberFormat formatter = NumberFormat("#,##0", "id_ID");

    // Format the integer
    return formatter.format(num);
  }

   String dateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMMM yy, HH:mm:ss');
    return formatter.format(dateTime);
  }

   String dmy(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(dateTime);
  }

   String dmyShort(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MMMM/yyyy');
    return formatter.format(dateTime);
  }

   String time(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(dateTime);
  }

   String monthYear(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(dateTime);
  }
}
