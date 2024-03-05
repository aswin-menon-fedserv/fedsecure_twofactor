package com.federal.fedsecure

import io.flutter.embedding.android.FlutterActivity


import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

import android.content.Intent
import android.app.Activity
//import org.xmlpull.v1.XmlPullParser

//import java.io.StringReader

//import org.xmlpull.v1.XmlPullParserFactory
import android.widget.Toast
import com.federal.fedsecure.activity.SplashScreen;


class MainActivity: FlutterActivity() {
    var RESULT = true;
    var trxnId = ""
    private val CHANNEL = "com.federal.fedsecure/root"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
//        getWindow().addFlags(android.view.WindowManager.LayoutParams.FLAG_SECURE);

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

             if (call.method == "startAuth"){
                trxnId = call.arguments as String
                captureIntent(trxnId)
            }
            else {
                result.notImplemented()
            }

        }
    }
    fun captureIntent(txnId: String){
        val intent = Intent(
            this,
            SplashScreen::class.java
        ) // Replace with your actual MainActivity class

        startActivity(intent)
//        val intent = Intent("in.gov.uidai.rdservice.face.CAPTURE")
//        intent.putExtra("request", createPidOptions(txnId, "auth"))
//        startActivityForResult(intent, 1)
    }
}
