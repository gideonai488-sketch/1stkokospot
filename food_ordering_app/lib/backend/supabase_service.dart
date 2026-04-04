import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_config.dart';

class SupabaseService {
  SupabaseService._();

  static final SupabaseService instance = SupabaseService._();

  bool _initialized = false;

  bool get isReady => _initialized;

  SupabaseClient get client {
    if (!_initialized) {
      throw StateError('Supabase not initialized.');
    }
    return Supabase.instance.client;
  }

  Future<void> initialize() async {
    if (_initialized || !AppConfig.hasSupabase) {
      return;
    }

    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      anonKey: AppConfig.supabaseAnonKey,
    );
    _initialized = true;
  }
}
