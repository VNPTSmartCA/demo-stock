package com.example.appcksmartca.demoappck

import android.content.Intent
import android.util.Log
import com.vnpt.egov.vnptsmartcaandroidsdk.Transaction
import com.vnpt.egov.vnptsmartcaandroidsdk.utils.VNPTSmartCAConfig
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    private val channelDeeplink = "com.vnpt.demo.PartnerSmartCA/VNPTSmartCAApp"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        Transaction.getInstance().setEnvironment(Transaction.ENVIRONMENT.DEVELOPMENT);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelDeeplink).setMethodCallHandler { call, result ->
            if (call.method.equals("OpenVNPTSmartCA")) {
                val data = call.arguments<HashMap<String, String>>()
                Transaction.getInstance().requestVNPTSmartCACallback(this, data);
                result.success("Open Successfully")
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        Log.i(VNPTSmartCAConfig.VNPT_SMARTCA_LOG_TAG, "resultCode: $resultCode" + "data: ${data.toString()}");
    }
}
