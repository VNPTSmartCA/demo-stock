package com.example.appcksmartca.demoappck

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.vnpt.egov.vnptsmartcaandroidsdk.Transaction
import com.vnpt.egov.vnptsmartcaandroidsdk.utils.VNPTSmartCAConfig
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.json.JSONObject
import java.lang.reflect.Method

class MainActivity: FlutterActivity() {

    private val channelDeeplink = "com.vnpt.demo.PartnerSmartCA/VNPTSmartCAApp"
    private val channelResult = "com.vnpt.demo.PartnerSmartCA/Result"
    private var eventReceivers: BroadcastReceiver? = null;
    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        Transaction.getInstance().setEnvironment(Transaction.ENVIRONMENT.DEVELOPMENT);
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelResult)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelDeeplink).setMethodCallHandler { call, result ->
            if (call.method.equals("OpenVNPTSmartCA")) {
                val data = call.arguments<HashMap<String, String>>()
//                eventReceivers = createChangeReceiver(call)
                Transaction.getInstance().requestVNPTSmartCACallback(this, data)
                result.success("Open Successfully")
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        Log.i(VNPTSmartCAConfig.VNPT_SMARTCA_LOG_TAG, "data: ${data.toString()}");
//        eventReceivers?.onReceive(context, data)
        if (resultCode == 0) {
            val json = JSONObject()


            val status = data?.extras?.getInt("status");
            val message = data?.extras?.getString("message");

            json.put("status", status.toString())
            json.put("message", message)

            methodChannel?.invokeMethod("SendResultFromVNPTSmartCA", json.toString())
            Log.i(VNPTSmartCAConfig.VNPT_SMARTCA_LOG_TAG, "status: ${status.toString()}")
            Log.i(VNPTSmartCAConfig.VNPT_SMARTCA_LOG_TAG, "message: $message")
        }
    }
}
