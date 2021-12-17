import 'package:http/http.dart' as http;
import 'package:demoappck/core/models/account_login.dart';
import 'package:demoappck/core/models/service_response.dart';
import 'package:demoappck/core/models/data_sign.dart';
import 'package:demoappck/core/models/network_service_response.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_session/flutter_session.dart';

import 'package:http/io_client.dart';

class RestClient {
  HttpClient httpClient;
  RestClient() : httpClient = new HttpClient();

  Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
  };
  Duration timeout = const Duration(seconds: 180);

  Future<NetworkServiceResponse<TokenData>> getAccessToken(
      AccountLogin data) async {
    var url = Uri.parse("https://rmgateway-mobile.vnptit.vn/auth/token");

    Map<String, String> content = data.toJson();

    IOClient ioClient = new IOClient(httpClient);
    var res = await ioClient
        .post(url, body: content, encoding: Encoding.getByName("utf-8"))
        .timeout(timeout);
    var result = processResponse(res);
    if (result == null) {
      return new NetworkServiceResponse(
        success: false,
        message: result.networkServiceResponse.message,
      );
    }
    if (result.mappedResult != null) {
      if (result.mappedResult['error'] != null) {
        return new NetworkServiceResponse(
            success: false, message: result.mappedResult['error_description']);
      }
      var res = TokenData.fromJson(result.mappedResult);
      await FlutterSession().set("token", res);

      return new NetworkServiceResponse(
          content: res,
          success: result.networkServiceResponse.success,
          message: '');
    }
    return new NetworkServiceResponse(
        success: result.networkServiceResponse.success,
        message: result.networkServiceResponse.message);
  }

  Future<String> createTrans() async {
    var accessToken = await FlutterSession().get("token");
    TokenData data;
    data = TokenData.fromJson(accessToken);
    var credentialId = await getCredentialId(data);

    var url = Uri.parse("https://rmgateway.vnptit.vn/en/csc/signature/sign");
    var dataModel = DatasModel(
        name: "trading_ck.xml",
        dataBase64:
            "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiIHN0YW5kYWxvbmU9InllcyI/Pg0KPFRyYWRlPg0KPGRhdGE+DQo8TGVuaE11YT5NVUE8L0xlbmhNdWE+DQo8TWFDSz5WQ0I8L01hQ0s+DQo8U29MdW9uZz4xMDAwPC9Tb0x1b25nPg0KPEdpYT45OS45PC9HaWE+DQo8L2RhdGE+DQo8L1RyYWRlPg==");

    List<DatasModel> lstFile = [];
    lstFile.add(dataModel);
    var req = RequestSignModel(
        credentialId: credentialId,
        refTranId: 'e442f592-f892-43dd-8a4b-d6339679f27f',
        description: 'Xác nhận giao dịch chứng khoán',
        datas: lstFile);

    headers1['Authorization'] = 'Bearer ${data.accessToken}';
    var content = json.encoder.convert(req);

    IOClient ioClient = new IOClient(httpClient);
    var res = await ioClient
        .post(
          url,
          headers: headers1,
          body: content,
        )
        .timeout(timeout);
    var result = processResponse(res);
    var res1 = ServiceResponse.fromJson(result.mappedResult);
    return res1.content['tranId'];
  }

  Future<String> getCredentialId(TokenData data) async {
    var url = Uri.parse("https://rmgateway.vnptit.vn/en/csc/credentials/list");
    headers1['Authorization'] = 'Bearer ${data.accessToken}';

    IOClient ioClient = new IOClient(httpClient);
    var res = await ioClient
        .post(
          url,
          headers: headers1,
          body: json.encoder.convert({}),
        )
        .timeout(timeout);
    var result = processResponse(res);
    var res1 = ServiceResponse.fromJson(result.mappedResult);
    return res1.content[0];
  }

  Map<String, String> headers1 = {
    "Content-Type": 'application/json',
    "Accept": 'application/json',
  };

  MappedNetworkServiceResponse<T> processResponse<T>(http.Response response) {
    if (!((response.statusCode != 200) || (response.body == null))) {
      var jsonResult = response.body;
      dynamic resultClass = jsonDecode(jsonResult);

      return new MappedNetworkServiceResponse<T>(
        mappedResult: resultClass,
        networkServiceResponse: new NetworkServiceResponse<T>(
          success: true,
          message: '',
        ),
      );
    } else {
      String error = '';
      var jsonResult = response.body;
      dynamic errorResponse = jsonDecode(jsonResult);
      var x = LoginErrorResponse.fromJson(errorResponse);
      error = x.message;
      return new MappedNetworkServiceResponse<T>(
        mappedResult: errorResponse,
        networkServiceResponse: new NetworkServiceResponse<T>(
          success: true,
          message: error,
        ),
      );
    }
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
