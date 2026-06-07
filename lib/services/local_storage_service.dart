import 'package:get_storage/get_storage.dart';
import 'package:waste_bank/models/user_model.dart';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'logged_user';

  final GetStorage _box;

  LocalStorageService() : _box = GetStorage();

  /// Save the auth token
  void saveToken(String token) {
    _box.write(_tokenKey, token);
  }

  /// Read the stored auth token
  String? getToken() {
    return _box.read<String>(_tokenKey);
  }

  /// Save the logged-in user
  void saveUser(UserModel user) {
    _box.write(_userKey, user.toJson());
  }

  /// Read the stored user
  UserModel? getUser() {
    final data = _box.read<Map<String, dynamic>>(_userKey);
    if (data == null) return null;
    return UserModel.fromJson(data);
  }

  /// Clear all auth data (token + user)
  void clearAuth() {
    _box.remove(_tokenKey);
    _box.remove(_userKey);
  }

  /// Check if a user is currently logged in
  bool get isLoggedIn => _box.hasData(_tokenKey);
}
