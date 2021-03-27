class EnvironmentConfig {
  static const String BASE_URL = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://appetizer-mdg.herokuapp.com',
  );
}
