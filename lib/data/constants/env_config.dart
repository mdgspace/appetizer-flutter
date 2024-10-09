class EnvironmentConfig {
  static const String BASE_URL = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://mess.iitr.ac.in',
  );

  static const String OAUTH_CLIENT_ID = String.fromEnvironment(
    'OAUTH_CLIENT_ID',
    defaultValue: 'kcqsgVWUfdXoys4AaeWQtvKuxMyPUNwEbcZw0By5',
  );

  static const String OAUTH_REDIRECT_URI = String.fromEnvironment(
    'OAUTH_REDIRECT_URI',
    defaultValue: 'https://mess.iitr.ac.in/api/user/oauth/redirect/',
  );

  static const String SENTRY_DSN = String.fromEnvironment('SENTRY_DSN');
  static const String MIXPANEL_PROJECT_KEY =
      String.fromEnvironment('MIXPANEL_PROJECT_KEY');
}
