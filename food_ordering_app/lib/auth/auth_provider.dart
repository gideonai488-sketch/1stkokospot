import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service.dart';
import 'auth_state.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService;
  AppAuthState _state = AppAuthState.unknown();
  late final StreamSubscription _sub;

  AuthProvider(this.authService) {
    _init();
  }

  AppAuthState get state => _state;

  void _init() {
    final user = authService.currentUser;
    if (user != null) {
      _state = AppAuthState.authenticated(user);
    } else {
      _state = AppAuthState.unauthenticated();
    }
    _sub = authService.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null && session.user != null) {
        _state = AppAuthState.authenticated(session.user!);
      } else {
        _state = AppAuthState.unauthenticated();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
