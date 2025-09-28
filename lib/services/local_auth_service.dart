import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Simple local authentication service using SharedPreferences
/// This is a temporary solution until Firebase is properly configured
class LocalAuthService {
  static const String _userKey = 'current_user';
  static const String _usersKey = 'registered_users';

  /// Sign in with email and password
  Future<Map<String, dynamic>?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey);
      
      if (usersJson != null) {
        final List<dynamic> users = json.decode(usersJson);
        
        for (final user in users) {
          if (user['email'] == email && user['password'] == password) {
            // Store current user
            await prefs.setString(_userKey, json.encode(user));
            return user;
          }
        }
      }
      
      return null; // User not found or wrong password
    } catch (e) {
      print('Error signing in: $e');
      return null;
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
      final prefs = await SharedPreferences.getInstance();
      
      // Check if user already exists
      final usersJson = prefs.getString(_usersKey);
      List<dynamic> users = [];
      
      if (usersJson != null) {
        users = json.decode(usersJson);
        
        // Check if email already exists
        for (final user in users) {
          if (user['email'] == email) {
            throw Exception('An account already exists with this email address.');
          }
        }
      }
      
      // Create new user
      final newUser = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'email': email,
        'password': password, // In production, this should be hashed
        'firstName': firstName,
        'lastName': lastName,
        'createdAt': DateTime.now().toIso8601String(),
      };
      
      users.add(newUser);
      
      // Save users list
      await prefs.setString(_usersKey, json.encode(users));
      
      // Store current user
      await prefs.setString(_userKey, json.encode(newUser));
      
      return newUser;
    } catch (e) {
      print('Error registering: $e');
      rethrow;
    }
  }

  /// Get current user
  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      
      if (userJson != null) {
        return json.decode(userJson);
      }
      
      return null;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  /// Check if user is signed in
  Future<bool> isSignedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  /// Update user profile
  Future<bool> updateUserProfile({
    String? firstName,
    String? lastName,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      
      if (userJson != null) {
        final user = json.decode(userJson);
        
        if (firstName != null) user['firstName'] = firstName;
        if (lastName != null) user['lastName'] = lastName;
        user['updatedAt'] = DateTime.now().toIso8601String();
        
        // Update current user
        await prefs.setString(_userKey, json.encode(user));
        
        // Update in users list
        final usersJson = prefs.getString(_usersKey);
        if (usersJson != null) {
          final List<dynamic> users = json.decode(usersJson);
          for (int i = 0; i < users.length; i++) {
            if (users[i]['id'] == user['id']) {
              users[i] = user;
              break;
            }
          }
          await prefs.setString(_usersKey, json.encode(users));
        }
        
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

  /// Clear all data (for testing)
  Future<void> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      await prefs.remove(_usersKey);
    } catch (e) {
      print('Error clearing data: $e');
    }
  }
}
