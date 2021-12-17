import 'dart:convert';

import 'package:flutter/services.dart';

class VNPTSmartCAChannel {
  static const platform =
      const MethodChannel('com.vnpt.demo.PartnerSmartCA/VNPTSmartCAApp');

  static const platformResult = MethodChannel("com.vnpt.demo.PartnerSmartCA/Result");

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

  Future<dynamic> receiveFromNative(MethodCall call) async {
    var jData;

    try {
      if (call.method == "SendResultFromVNPTSmartCA") {
        final String data = call.arguments;
        jData = await jsonDecode(data);
      }
    } on PlatformException catch (error) {
      print(error);
    }
    //
    // setState(() {
    //   status = jData['status'];
    //   message = jData['message'];
    // });

    return jData;
  }
}
