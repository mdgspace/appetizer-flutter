class EnvironmentConfig {
  static const String BASE_URL = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://appetizer-mdg.herokuapp.com',
  );

  static const String SENTRY_DSN = String.fromEnvironment('SENTRY_DSN');
}
