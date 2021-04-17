import 'package:intl/intl.dart';

class StringUtils {
  static final Map<String, String> _hostelMap = {
    'Azad Bhawan': 'AZ',
    'Cautley Bhawan': 'CB',
    'Ganga Bhawan': 'GA',
    'Govind Bhawan': 'GB',
    'Indira Bhawan': 'IB',
    'Jawahar Bhawan': 'JB',
    'Kasturba Bhawan': 'KB',
    'Malviya Bhawan': 'MB',
    'Radhakrishnan Bhawan': 'RKB',
    'Rajendra Bhawan': 'RJB',
    'Rajiv Bhawan': 'RB',
    'Ravindra Bhawan': 'RV',
    'Sarojini Bhawan': 'SB',
    'Vigyan Kunj': 'VK',
    'Development Government': 'DVG',
    'Development Private': 'DVP',
  };

  static String hostelCodeToName(String code) {
    return _hostelMap.keys.firstWhere(
      (k) => _hostelMap[k] == code,
      orElse: () => null,
    );
  }

  static String hostelNameToCode(String name) {
    return _hostelMap[name];
  }

  static String appLinkToShareText(String link) {
    return 'Let me recommend you this application:\n $link';
  }

  static int monthStringToInt(String month) {
    if (month == 'All') return 0;
    return DateFormat.MMMM().parse(month).month;
  }
}
