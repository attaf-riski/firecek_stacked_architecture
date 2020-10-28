package com.example.firecek_stacked_architecture

import com.example.firecek_stacked_architecture.FirebaseCloudMessagingPluginRegistrant
import com.example.firecek_stacked_architecture.FlutterLocalNotificationPluginRegistrant

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback{

    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        if (registry != null) {
            FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
            FlutterLocalNotificationPluginRegistrant.registerWith(registry)
        }
    }
    
}