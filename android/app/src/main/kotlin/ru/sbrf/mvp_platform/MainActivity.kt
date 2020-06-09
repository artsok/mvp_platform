package ru.sbrf.mvp_platform

import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("dd556d40-a275-4ffb-a486-82e62b513e9b")
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
