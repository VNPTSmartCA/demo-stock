/// Tham so get access_token
class AccountLogin {
  static const String PATH = '/oauth/token';
  String clientId;
  String clientSecret;
  String grantType;
  String username;
  String password;

  AccountLogin(
      {this.grantType: 'password',
      this.clientId: '4185-637127995547330633.apps.signserviceapi.com',
      this.clientSecret: 'NGNhMzdmOGE-OGM2Mi00MTg0',
      required this.username,
      required this.password});

  Map<String, String> toJson() => {
        'grant_type': grantType,
        'client_id': clientId,
        'client_secret': clientSecret,
        'username': username,
        'password': password,
      };
}

class AppLogin {
  String clientId;
  String clientSecret;
  String grantType;

  AppLogin(
      {this.grantType: 'client_credentials',
      this.clientId: '4cfa-637406049184925437.apps.signserviceapi.com',
      this.clientSecret: 'YTRlNjgwYmU-ZDVkNy00Y2Zh'});

  Map<String, String> toJson() => {
        'grant_type': grantType,
        'client_id': clientId,
        'client_secret': clientSecret,
      };
}

class LoginResponse {
  String status;
  TokenData data;
  LoginResponse({required this.status, required this.data});

  LoginResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = TokenData.fromJson(json['data']);
}

class TokenData {
  final String accessToken;
  set accessToken(String token) {
    accessToken = token;
  }

  final String refreshToken;
  final int expiresIn;
  final DateTime expireTime;
  TokenData.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        refreshToken = json['refresh_token'],
        expiresIn = json['expires_in'],
        expireTime = DateTime.now()
  // expireTime = DateFormat('EEE, d MMM yyyy hh:mm:ss').parse(json['.expires'], true)
  ;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["access_token"] = accessToken;
    data["refreshToken"] = refreshToken;
    data['expires_in'] = expiresIn;
    // data['.expires'] = DateFormat('EEE, d MMM yyyy hh:mm:ss').format(expireTime);
    return data;
  }
}

class LoginErrorResponse {
  final int code;
  final String codeDesc;
  final String description;
  final String message;

  LoginErrorResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        codeDesc = json['codeDesc'],
        description = json['message'],
        message = json['message'];
}
