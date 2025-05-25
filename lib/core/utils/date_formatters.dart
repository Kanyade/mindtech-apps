// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

abstract class DateFormatters {
  /// A date format that formats dates as 'HH:mm'.
  /// Example: '09:47'
  ///
  static DateFormat HHmm = DateFormat('HH:mm');

  /// A date format that formats dates as 'yyyy-MM-dd'.
  /// Example: '2023-01-01'
  static DateFormat yyyyMMdd = DateFormat('yyyy-MM-dd');

  /// A date format that formats dates as 'yyyy-MM-dd hh:mm:ss'.
  /// Example: '2023-01-01 16:20:00'
  static DateFormat yyyyMMddhhmmss = DateFormat('yyyy-MM-dd hh:mm:ss');

  /// A date format that formats dates as 'MMMM d, yyyy'.
  /// Example: 'January 1, 2023'
  static DateFormat mmmmDyyyy = DateFormat('MMMM d, yyyy');

  /// A date format that formats dates as 'dd-MM-yyyy'.
  /// Example: '01-01-2023'
  static DateFormat ddMMyyyy = DateFormat('dd-MM-yyyy');

  /// A date format that formats dates as 'hh:mm, dd-MMMM'.
  /// Example: '12:00, 01-January'
  static DateFormat hhmmddMMMM = DateFormat('hh:mm, dd-MMMM');

  /// A date format that formats dates as 'MMM dd'.
  /// Example: 'Jan 01'
  static DateFormat MMMdd = DateFormat('MMM dd');

  /// A date format that formats dates as 'd MMM'.
  /// Example: '1 Jan'
  static DateFormat dMMM = DateFormat('d MMM');

  /// A date format that formats dates as 'MMMM yyyy'.
  /// Example: 'January 2023'
  static DateFormat mmmmyyyy = DateFormat('MMMM yyyy');

  /// A date format that fromats dates as h:mm a | MM/dd/yyyy
  /// Example: 8:32 PM | 11/05/2024
  static DateFormat hmmaMMddyyy = DateFormat('h:mm a | MM/dd/yyyy');

  /// A date format that fromats dates as EEEE / MMMM dd \nh:mm a
  /// Example:
  /// Friday / March 07
  /// 2:00 PM
  static DateFormat EEEEMMddhmma = DateFormat('EEEE / MMMM dd \nh:mm a');

  /// A date format that fromats dates as EEEE, MMMM dd yyyy, \nh:mm a
  /// Example:
  /// Friday, March 07 2024,
  /// 2:00 PM
  static DateFormat EEEEMMddyyyyhmma = DateFormat('EEEE, MMMM dd yyyy, \nh:mm a');
}
