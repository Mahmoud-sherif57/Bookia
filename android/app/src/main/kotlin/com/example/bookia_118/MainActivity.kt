package com.example.bookia_118

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()

//package com.example.bookia_118
//
//import android.content.pm.PackageInfo
//import android.content.pm.PackageManager
//import android.util.Base64
//import android.util.Log
//import io.flutter.embedding.android.FlutterActivity
//import java.security.MessageDigest
//import java.security.NoSuchAlgorithmException
//
//class MainActivity: FlutterActivity() {
//    override fun onCreate(savedInstanceState: android.os.Bundle?) {
//        super.onCreate(savedInstanceState)
//
//        try {
//            val info: PackageInfo = packageManager.getPackageInfo(
//                "com.example.bookia_118", // اسم حزمة التطبيق
//                PackageManager.GET_SIGNATURES
//            )
//            for (signature in info.signatures) {
//                val md: MessageDigest = MessageDigest.getInstance("SHA")
//                md.update(signature.toByteArray())
//                val keyHash = String(Base64.encode(md.digest(), 0))
//                Log.d("KeyHash:", keyHash) // هنا هيظهر في اللوج عند تشغيل التطبيق
//            }
//        } catch (e: PackageManager.NameNotFoundException) {
//            e.printStackTrace()
//        } catch (e: NoSuchAlgorithmException) {
//            e.printStackTrace()
//        }
//    }
//}
