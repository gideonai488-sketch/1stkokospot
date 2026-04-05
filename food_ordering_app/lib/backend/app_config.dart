// --- HARDCODED SUPABASE CONFIG FOR DEPLOYMENT ---
// If you want to use environment variables, set them in your build pipeline.
class AppConfig {
  static const String supabaseUrl = 'https://tchhzdwdikfflmkeawau.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRjaGh6ZHdkaWtmZmxta2Vhd2F1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQ5OTY5MjAsImV4cCI6MjA5MDU3MjkyMH0.VvW46M_ezLxvCRBDKAH0qChFDwgNA0hYN3Z-LvKa634';
  static const String paystackCallbackUrl = 'https://localhost/checkout/complete';
  static const bool hasSupabase = true;
}
