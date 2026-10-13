/// Sync with Supabase. Implemented in full in the sync step; this keeps the
/// app running local-only when no backend is configured.
library;

class SyncService {
  static const url = String.fromEnvironment('SUPABASE_URL');
  static const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  static bool get configured => url.isNotEmpty && anonKey.isNotEmpty;

  static Future<void> initIfConfigured() async {}
}
