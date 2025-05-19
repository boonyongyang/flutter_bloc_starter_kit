import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';

// TODO: Create a User model for Hive storage if more details are needed
// class User {
//   String username;
//   String? email; // Example additional field
//   // Add other fields as needed
//   User({required this.username, this.email});
// }
// TODO: Create a TypeAdapter for the User model if you use a custom class

class AuthService {
  final FlutterSecureStorage _secureStorage;
  final Uuid _uuid;
  late Box _userBox; // Hive box for user data

  static const String _sessionTokenKey = 'user_session_token';
  static const String _userBoxName = 'userBox';
  static const String _usernameKey = 'current_username';
  // TODO: Add keys for other user details if stored directly in userBox
  // static const String _emailKey = 'current_user_email';

  AuthService(this._secureStorage, this._uuid);

  Future<void> init() async {
    // Ensure Hive is initialized and box is opened
    // This might be called in main.dart or when the service is first created
    if (!Hive.isBoxOpen(_userBoxName)) {
      _userBox = await Hive.openBox(_userBoxName);
    } else {
      _userBox = Hive.box(_userBoxName);
    }
  }

  Future<bool> isLoggedIn() async {
    // Check if a session token exists
    final token = await _secureStorage.read(key: _sessionTokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<void> login(String username, String password) async {
    // For demo purposes, we're not validating password against a backend.
    // We generate a new session token and store it.
    final sessionToken = _uuid.v4();
    await _secureStorage.write(key: _sessionTokenKey, value: sessionToken);

    // Save username to Hive
    await _userBox.put(_usernameKey, username);
    // TODO: Save other user details to Hive
    // await _userBox.put(_emailKey, 'user@example.com'); // Example
    // Or store a User object:
    // final user = User(username: username, email: 'user@example.com');
    // await _userBox.put('currentUser', user);
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: _sessionTokenKey);
    await _userBox.delete(_usernameKey);
    // TODO: Delete other user details from Hive
    // await _userBox.delete(_emailKey);
    // await _userBox.delete('currentUser');
  }

  Future<String?> getCurrentUsername() async {
    if (!_userBox.isOpen) {
      await init(); // Ensure box is open
    }
    return _userBox.get(_usernameKey) as String?;
  }

  // TODO: Add methods to retrieve other user details from Hive if needed
  // Future<User?> getCurrentUser() async {
  //   if (!_userBox.isOpen) {
  //     await init();
  //   }
  //   return _userBox.get('currentUser') as User?;
  // }
}
