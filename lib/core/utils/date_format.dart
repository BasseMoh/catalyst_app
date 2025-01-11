 import 'package:intl/intl.dart';

String formatDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      return dateFormat.format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }