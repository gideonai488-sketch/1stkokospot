import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_config.dart';

class SupabaseService {
  static final SupabaseService instance = SupabaseService._();
  SupabaseService._();

  Future<void> initialize() async {
    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      anonKey: AppConfig.supabaseAnonKey,
      debug: true,
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}
