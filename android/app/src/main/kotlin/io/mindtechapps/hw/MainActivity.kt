package io.mindtechapps.hw

import android.view.WindowManager.LayoutParams
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity (){

     override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        this.window?.addFlags(LayoutParams.FLAG_SECURE)
    }
}
