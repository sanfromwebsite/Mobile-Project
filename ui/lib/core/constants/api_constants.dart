class ApiConstants {
  // Base URL for Android Emulator to access localhost
  static const String baseUrl = 'http://10.0.2.2:5239';
  
  // Auth Endpoints
  static const String login = '$baseUrl/Auth/login';
  static const String logout = '$baseUrl/Auth/logout';
}
