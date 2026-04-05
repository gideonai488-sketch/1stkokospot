import 'package:supabase_flutter/supabase_flutter.dart';

enum AppAuthStatus { unknown, authenticated, unauthenticated }

class AppAuthState {
  final AppAuthStatus status;
  final User? user;
  const AppAuthState({required this.status, this.user});

  factory AppAuthState.unknown() => const AppAuthState(status: AppAuthStatus.unknown);
  factory AppAuthState.authenticated(User user) => AppAuthState(status: AppAuthStatus.authenticated, user: user);
  factory AppAuthState.unauthenticated() => const AppAuthState(status: AppAuthStatus.unauthenticated);
}
