package com.example.mumbi_app;

import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.app.FlutterApplication;
import io.flutter.view.FlutterMain;
public class Application extends FlutterApplication implements PluginRegistrantCallback {

    @Override
    public void onCreate() {
        super.onCreate();
        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
        FlutterMain.startInitialization(this);
    }

    @Override
    public void registerWith(PluginRegistry registry) {
    }
}
