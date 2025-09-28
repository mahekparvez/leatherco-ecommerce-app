import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

/// Authentication provider for managing user authentication state
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _user;
  bool _isLoading = false;
  String? _errorMessage;

  /// Get current user
  Map<String, dynamic>? get user => _user;

  /// Check if user is authenticated
  bool get isAuthenticated => _user != null;

  /// Check if loading
  bool get isLoading => _isLoading;

  /// Get error message
  String? get errorMessage => _errorMessage;

  /// Initialize auth provider
  AuthProvider() {
    _init();
  }

  /// Initialize authentication state
  void _init() async {
    await _checkAuthState();
  }

  /// Check authentication state
  Future<void> _checkAuthState() async {
    try {
      final user = await _authService.getCurrentUser();
      _user = user;
      notifyListeners();
    } catch (e) {
      _user = null;
      notifyListeners();
    }
  }

  /// Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Sign in with email and password
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final result = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result != null) {
        _user = result;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Register with email and password
  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final result = await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      if (result != null) {
        _user = result;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      _setLoading(true);
      _setError(null);
      await _authService.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Reset password
  Future<bool> resetPassword(String email) async {
    try {
      _setLoading(true);
      _setError(null);
      await _authService.resetPassword(email);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Update user profile
  Future<bool> updateUserProfile({
    String? firstName,
    String? lastName,
  }) async {
    try {
      _setLoading(true);
      _setError(null);
      await _authService.updateUserProfile(
        firstName: firstName,
        lastName: lastName,
      );
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Get user data
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      return await _authService.getUserData();
    } catch (e) {
      _setError(e.toString());
      return null;
    }
  }

  /// Sign in (alias for signInWithEmailAndPassword)
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Register (alias for registerWithEmailAndPassword)
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    await registerWithEmailAndPassword(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
