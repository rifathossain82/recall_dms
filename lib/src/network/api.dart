class Api{
  static const String _baseUrl = 'https://dms.amarsolution.com/api/v1';
  static String get login => '$_baseUrl/login';
  static String get logout => '$_baseUrl/logout';
  static String get getAllVehicle => '$_baseUrl/driver/vehicle/index';
}