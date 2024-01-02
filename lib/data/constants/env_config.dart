class EnvironmentConfig {
  static const String BASE_URL = String.fromEnvironment(
    'BASE_URL',
    defaultValue:
        'https://b657-2405-201-a409-1996-41f0-89b5-4e65-f2cf.ngrok-free.app',
  );

  static const String OAUTH_CLIENT_ID = String.fromEnvironment(
    'OAUTH_CLIENT_ID',
    defaultValue: 'kcqsgVWUfdXoys4AaeWQtvKuxMyPUNwEbcZw0By5',
  );

  static const String OAUTH_REDIRECT_URI = String.fromEnvironment(
    'OAUTH_REDIRECT_URI',
    defaultValue: 'https://appetizer.onrender.com/oauth/',
  );

  static const String SENTRY_DSN = String.fromEnvironment('SENTRY_DSN');
}
