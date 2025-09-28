import 'local_auth_service.dart';

/// Authentication service for handling user login, registration, and logout
/// Using local storage for now (can be replaced with Firebase later)
class AuthService {
  final LocalAuthService _localAuth = LocalAuthService();

  /// Get current user
  Future<Map<String, dynamic>?> get currentUser => _localAuth.getCurrentUser();

  /// Get current user (synchronous method for provider)
  Future<Map<String, dynamic>?> getCurrentUser() async {
    return await _localAuth.getCurrentUser();
  }

  /// Sign in with email and password
  Future<Map<String, dynamic>?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _localAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (user == null) {
        throw Exception('Invalid email or password.');
      }
      
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Register with email and password
  Future<Map<String, dynamic>?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final user = await _localAuth.registerWithEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _localAuth.signOut();
  }

  /// Reset password (not implemented in local auth)
  Future<void> resetPassword(String email) async {
    throw Exception('Password reset not available in local authentication. Please contact support.');
  }

  /// Update user profile
  Future<void> updateUserProfile({
    String? firstName,
    String? lastName,
  }) async {
    await _localAuth.updateUserProfile(
      firstName: firstName,
      lastName: lastName,
    );
  }

  /// Get user data
  Future<Map<String, dynamic>?> getUserData() async {
    return await _localAuth.getCurrentUser();
  }

  /// Check if user is signed in
  Future<bool> isSignedIn() async {
    return await _localAuth.isSignedIn();
  }
}
