package com.example.flutter_base;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.support.annotation.NonNull;
import android.support.annotation.RequiresApi;
import android.support.design.widget.Snackbar;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.view.View;

import com.walkbase.sdk.WalkbaseManager;
import com.walkbase.sdk.WalkbaseForegroundListener;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements ActivityCompat.OnRequestPermissionsResultCallback {
  private static int PERMISSIONS_REQUEST_CODE = 8391;
  private WalkbaseManager walkbaseManager;
  private String TAG = "MainActivity";
  private static final String CHANNEL = "example.com/flutterbase";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    
    walkbaseManager = new WalkbaseManager(this);

    if(!havePermissions()) {
      Log.i(TAG, "Requesting permissions needed for this app.");
      requestPermissions();
    }
    else {
      startWalkbaseSDK();
    }
    
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
                if (methodCall.method.equals("getDeviceId")) {
                  result.success(getDeviceId());
                } else {
                  result.notImplemented();
                }
              }
            }
    );
  }

  private String getDeviceId() {
    String deviceId = Settings.Secure.getString(getApplicationContext().getContentResolver(), Settings.Secure.ANDROID_ID);
    if (deviceId.isEmpty()) {
      deviceId = "userId";
    }
    return deviceId;
  }

  private void startWalkbaseSDK() {
    walkbaseManager.startWithApiKey("VZHkscRFhAjkScc");
  }

  @Override
  protected void onResume() {
    super.onResume();

    walkbaseManager.onResume();
    walkbaseManager.setUserID(getDeviceId());
  }

  @Override
  protected void onStop() {
    super.onStop();

    walkbaseManager.onStop();
  }

  private boolean havePermissions() {
    return ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED;
  }

  private void requestPermissions() {
    ActivityCompat.requestPermissions(this, new String[] {Manifest.permission.ACCESS_FINE_LOCATION}, PERMISSIONS_REQUEST_CODE);
  }

  @Override
  @RequiresApi(api = Build.VERSION_CODES.M)
  public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
    if (requestCode != PERMISSIONS_REQUEST_CODE) {
      return;
    }

    for (int i = 0; i < permissions.length; i++) {
      if (grantResults[i] == PackageManager.PERMISSION_GRANTED) {
        Log.i(TAG, "Permission granted, starting the Walkbase SDK");
        startWalkbaseSDK();
      }
      else {
        if (shouldShowRequestPermissionRationale(permissions[i])) {
          Log.i(TAG, "Permission denied without 'NEVER ASK AGAIN': " + permissions[i]);
          showRequestPermissionsSnackbar();
        }
        else {
          Log.i(TAG, "Permission denied with 'NEVER ASK AGAIN': " + permissions[i]);
          showLinkToSettingsSnackbar();
        }
      }
    }
  }

  private void showLinkToSettingsSnackbar() {
    Snackbar.make(this.getFlutterView(), "Permission denied", Snackbar.LENGTH_INDEFINITE)
            .setAction("Permission settings", new View.OnClickListener() {
              @Override
              public void onClick(View view) {
                Intent intent = new Intent();
                intent.setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
                Uri uri = Uri.fromParts("package", BuildConfig.APPLICATION_ID, null);
                intent.setData(uri);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(intent);
              }
    }).show();
  }

  private void showRequestPermissionsSnackbar() {
    Snackbar.make(this.getFlutterView(), "We need permissions to access your location", Snackbar.LENGTH_INDEFINITE)
            .setAction("OK", new View.OnClickListener() {
              @Override
              public void onClick(View view) {
                requestPermissions();
              }
            }).show();
  }
}
