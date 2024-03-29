import 'package:appetizer/data/constants/env_config.dart';

class AppConstants {
  /// USER AUTHENTICATION CONSTANTS
  static const String USER_AUTH_WRONG_CREDENTIALS =
      'Invalid Credentials, Please check.';
  static const String USER_AUTH_USER_NOT_FOUND =
      'User Not found, try Signing Up.';
  static const String USER_NOT_AUTHORIZED_TO_FETCH_USER =
      'You are not authorized to fetch this User';
  static const String USER_NOT_FOUND = 'No User Found';

  /// MENU CONSTANTS
  static const String MENU_NOT_FOUND = 'No Menu Found';

  /// GENERIC FAILURE CONSTANTS
  static const String BAD_RESPONSE_FORMAT = 'Bad Response Format';
  static const String GENERIC_FAILURE =
      'Something Wrong Occured! Please try again.';
  static const String NO_INTERNET_CONNECTION = 'No Internet Connection';
  static const String HTTP_EXCEPTION = 'Unable to fetch response';
  static const String UNAUTHORIZED_EXCEPTION =
      'Unauthorized to fetch the resource.';
  static const List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  // Local db
  static const String localDb = "appiLocalDb";

  // Redirect link for issues
  static const String issueUrl = "https://mess.iitr.ac.in/issues";

  static const String omniportSignUpURL =
      'https://channeli.in/oauth/authorise/?client_id=${EnvironmentConfig.OAUTH_CLIENT_ID}&redirect_uri=${EnvironmentConfig.OAUTH_REDIRECT_URI}';

  /// Response values returned by api for different categories of user
  static const REGISTERED_USER_API_STATUS = "Registered";
  static const UNREGISTERED_USER_API_STATUS = "Enrollment does not exists";
  static const TEMPORARY_USER_API_STATUS = "Temporary";

  /// api error messages
  static const MENU_NOT_UPLOADED = 'Menu not uploaded yet';

  // Storage Keys
  static const FCM_TOKEN = 'fcm_token';
  static const AUTH_TOKEN = 'auth_token';
  static const LOGGED_IN = 'logged_in';
}
