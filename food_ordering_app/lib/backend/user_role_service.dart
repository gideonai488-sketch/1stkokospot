import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_role.dart';

class UserRoleService {
  final SupabaseClient client;
  UserRoleService(this.client);

  Future<UserRoleType> getUserRole(String userId) async {
    final res = await client
        .from('user_roles')
        .select('role')
        .eq('user_id', userId)
        .single();
    return UserRoleType.values.firstWhere((e) => e.name == res['role']);
  }

  Future<bool> hasRole(String userId, UserRoleType role) async {
    final res = await client
        .from('user_roles')
        .select('role')
        .eq('user_id', userId)
        .eq('role', role.name)
        .maybeSingle();
    return res != null;
  }
}
