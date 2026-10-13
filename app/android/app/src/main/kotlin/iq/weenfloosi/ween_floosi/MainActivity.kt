package iq.weenfloosi.ween_floosi

import android.Manifest
import android.content.pm.PackageManager
import android.net.Uri
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/** FlutterFragmentActivity is required by local_auth (fingerprint lock). */
class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "ween_floosi/sms").setMethodCallHandler { call, result ->
            when (call.method) {
                "readInbox" -> {
                    if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_SMS) != PackageManager.PERMISSION_GRANTED) {
                        result.error("NO_PERMISSION", "READ_SMS not granted", null)
                        return@setMethodCallHandler
                    }
                    val since = (call.argument<Number>("since") ?: 0).toLong()
                    try {
                        result.success(readInbox(since))
                    } catch (e: Exception) {
                        result.error("READ_FAILED", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    /** Messages newer than [since] (epoch millis), oldest first, at most 500. */
    private fun readInbox(since: Long): List<Map<String, Any?>> {
        val out = ArrayList<Map<String, Any?>>()
        val cursor = contentResolver.query(
            Uri.parse("content://sms/inbox"),
            arrayOf("_id", "address", "body", "date"),
            "date > ?",
            arrayOf(since.toString()),
            "date ASC",
        ) ?: return out
        cursor.use {
            val id = it.getColumnIndexOrThrow("_id")
            val address = it.getColumnIndexOrThrow("address")
            val body = it.getColumnIndexOrThrow("body")
            val date = it.getColumnIndexOrThrow("date")
            while (it.moveToNext() && out.size < 500) {
                out.add(mapOf(
                    "id" to it.getLong(id),
                    "address" to it.getString(address),
                    "body" to it.getString(body),
                    "date" to it.getLong(date),
                ))
            }
        }
        return out
    }
}
