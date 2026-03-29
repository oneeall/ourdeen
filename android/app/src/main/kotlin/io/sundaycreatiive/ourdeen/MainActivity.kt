package io.sundaycreatiive.ourdeen

import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Enable 120 FPS mode for devices with high refresh rate displays (120Hz)
        // This requires Android 11 (API 30) or higher
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            // Set the display mode to prefer high refresh rate (120 Hz)
            window.attributes = window.attributes.apply {
                // Allow the display to run at its maximum refresh rate
                // On 120Hz displays, this will enable 120 FPS
                // On 60Hz displays, it will stay at 60 FPS
                preferredRefreshRate = 120f
            }

            // Alternatively, use window mode for high refresh rate
            try {
                val windowParams = WindowManager.LayoutParams()
                windowParams.preferredRefreshRate = 120f
                window.attributes = windowParams
            } catch (e: Exception) {
                // Fallback silently if preferredRefreshRate is not supported
            }
        }

        // For devices with Android 10 or lower, set the window flags
        // to allow high performance mode
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            window.attributes = window.attributes.apply {
                layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES
            }
        }
    }
}
