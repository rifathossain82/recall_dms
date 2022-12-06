class Api{
  static const String _baseUrl = 'https://recalldigi.com/api/v1/';
  static String get login => '${_baseUrl}login';
  static String get logout => '${_baseUrl}logout';
  static String get changePassword => '${_baseUrl}reset-password';
  static String get getUser => '${_baseUrl}user';
  static String get getAllVehicle => '${_baseUrl}driver/vehicle/index';
  static String get getAllTMTL => '${_baseUrl}driver/tmtl/index';
  static String get getTMTLDetails => '${_baseUrl}driver/tmtl/show';
  static String get getVehicleDetails => '${_baseUrl}driver/vehicle/show';
}