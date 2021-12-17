import 'package:flutter/services.dart';

class VNPTSmartCAChannel {
  static const platform =
      const MethodChannel('com.vnpt.demo.PartnerSmartCA/VNPTSmartCAApp');

  VNPTSmartCAChannel._internal();

  static final VNPTSmartCAChannel instance = VNPTSmartCAChannel._internal();

  Future<void> requestMapping(String tranId, String clientId) async {
    try {
      await platform.invokeMethod('OpenVNPTSmartCA', <String, String>{
        "tranId": tranId,
        "clientId": clientId,
      });
    } catch (e) {
      print('Error when requestMapping(): $e');
    }
  }
}
