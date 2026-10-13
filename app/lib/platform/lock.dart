library;

import 'package:local_auth/local_auth.dart';

class AppLock {
  static final _auth = LocalAuthentication();

  static Future<bool> available() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  /// Fingerprint, face or the phone's own PIN.
  static Future<bool> unlock() async {
    try {
      return await _auth.authenticate(localizedReason: 'افتحوا وين فلوسي', persistAcrossBackgrounding: true);
    } catch (_) {
      return false;
    }
  }
}
