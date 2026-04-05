import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile.dart';

class ProfileService {
  final SupabaseClient client;
  ProfileService(this.client);

  Future<Profile?> fetchProfile(String userId) async {
    final res = await client
        .from('profiles')
        .select()
        .eq('user_id', userId)
        .single();
    if (res == null) return null;
    return Profile.fromJson(res);
  }

  Future<void> upsertProfile(Profile profile) async {
    await client.from('profiles').upsert(profile.toJson());
  }
}
