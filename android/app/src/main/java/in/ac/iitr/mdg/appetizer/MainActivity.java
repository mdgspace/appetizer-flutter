package in.ac.iitr.mdg.appetizer;

import android.os.Bundle;
import android.content.Intent;
import android.os.Bundle;
import java.nio.ByteBuffer;
import android.net.Uri;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.ActivityLifecycleListener;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private Intent intentFilterIntent;
    private Uri intentUri;
    private String sharedText;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        getIntentFilter();
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "app.channel.shared.data")
                .setMethodCallHandler(
                    (call, result) -> {
                        if (call.method.contentEquals("getCode")) {
                            result.success(sharedText);
                            sharedText = null;
                        }
                }
        );
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
