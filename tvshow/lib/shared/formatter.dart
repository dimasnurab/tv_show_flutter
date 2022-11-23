import 'package:intl/intl.dart';

class Formatter {
  static String year({dynamic value}) {
    if (value != null) {
      DateTime _parse = DateTime.parse(value.toString());
      var format = DateFormat("yyyy");

      return format.format(_parse);
    } else {
      return "-";
    }
  }

  static String ddMMMMYYYY({dynamic value}) {
    if (value != null) {
      DateTime _parse = DateTime.parse(value.toString());
      var format = DateFormat("dd MMMM yyyy", "id");

      return format.format(_parse);
    } else {
      return "-";
    }
  }
}
