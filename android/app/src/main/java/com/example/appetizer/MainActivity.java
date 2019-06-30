package com.example.appetizer;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.Intent;
import android.os.Bundle;

import java.nio.ByteBuffer;

import android.net.Uri;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.ActivityLifecycleListener;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {


    private Intent intentFilterIntent;
    private Uri intentUri;
    private String sharedText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        getIntentFilter();
        new MethodChannel(getFlutterView(), "app.channel.shared.data").setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.contentEquals("getCode")) {
                            result.success(sharedText);
                            sharedText = null;
                        }
                    }
                });
    }

    private void getIntentFilter() {
        //get intent filter for a param(channeliRedirectUriCode) and send request to verify whether user in a new user or an already existing user
        intentFilterIntent = getIntent();
        if (intentFilterIntent != null) {
            intentUri = intentFilterIntent.getData();
            String code;
            if (intentUri != null) {
                code = intentUri.getQueryParameter("code");
                sharedText = code;
            }
        }
    }
}
