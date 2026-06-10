import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:waste_bank/models/user_model.dart';
import 'package:waste_bank/services/api_client.dart';
import 'package:waste_bank/services/local_storage_service.dart';

/// Type alias for auth responses
typedef AuthResult = Either<String, AuthResponse>;
typedef ProfileResult = Either<String, UserModel>;

/// Response from login/register endpoints
///
/// The API wraps the response in a `data` object.
class AuthResponse {
  final String token;
  final UserModel user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    // The API returns { success, message, data: { token, user } }
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return AuthResponse(
      token: data['token'] as String? ?? '',
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class AuthService {
  final ApiClient _apiClient;
  final LocalStorageService _storage;

  AuthService(this._apiClient, this._storage);

  /// Farmer login with phone and password
  Future<AuthResult> loginFarmer({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/login',
        data: {
          'phone': phone,
          'password': password,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data as Map<String, dynamic>);
      _apiClient.setAuthToken(authResponse.token);
      _storage.saveUser(authResponse.user);
      return Right(authResponse);
    } on DioException catch (e) {
      return Left(e.message ?? 'Login failed. Please try again.');
    } catch (e) {
      return Left('An unexpected error occurred. Please try again.');
    }
  }

  /// Organization / factory login with email and password
  Future<AuthResult> loginOrg({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        '/org/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data as Map<String, dynamic>);
      _apiClient.setAuthToken(authResponse.token);
      _storage.saveUser(authResponse.user);
      return Right(authResponse);
    } on DioException catch (e) {
      return Left(e.message ?? 'Login failed. Please try again.');
    } catch (e) {
      return Left('An unexpected error occurred. Please try again.');
    }
  }

  /// Register a new general user
  Future<AuthResult> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data as Map<String, dynamic>);
      _apiClient.setAuthToken(authResponse.token);
      _storage.saveUser(authResponse.user);
      return Right(authResponse);
    } on DioException catch (e) {
      return Left(e.message ?? 'Registration failed. Please try again.');
    } catch (e) {
      return Left('An unexpected error occurred. Please try again.');
    }
  }

  /// Register as a farmer
  Future<AuthResult> registerFarmer({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required String nationalId,
    required String landSize,
    required String cropsType,
    required String addressVillage,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/register/farmer',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'national_id': nationalId,
          'land_size': landSize,
          'crops_type': cropsType,
          'address_village': addressVillage,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data as Map<String, dynamic>);
      _apiClient.setAuthToken(authResponse.token);
      _storage.saveUser(authResponse.user);
      return Right(authResponse);
    } on DioException catch (e) {
      return Left(e.message ?? 'Farmer registration failed. Please try again.');
    } catch (e) {
      return Left('An unexpected error occurred. Please try again.');
    }
  }

  /// Register as a factory/organization
  Future<AuthResult> registerFactory({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required String nationalId,
    required String factoryOwnerName,
    required String industrialRegistrationNumber,
    required String industryType,
    required String addressVillage,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/register/factory',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'national_id': nationalId,
          'factory_owner_name': factoryOwnerName,
          'industrial_registration_number': industrialRegistrationNumber,
          'industry_type': industryType,
          'address_village': addressVillage,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data as Map<String, dynamic>);
      _apiClient.setAuthToken(authResponse.token);
      _storage.saveUser(authResponse.user);
      return Right(authResponse);
    } on DioException catch (e) {
      return Left(e.message ?? 'Factory registration failed. Please try again.');
    } catch (e) {
      return Left('An unexpected error occurred. Please try again.');
    }
  }

  /// Login with Google
  Future<AuthResult> loginWithGoogle(String googleToken) async {
    try {
      final response = await _apiClient.post(
        '/auth/google',
        data: {
          'google_token': googleToken,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data as Map<String, dynamic>);
      _apiClient.setAuthToken(authResponse.token);
      _storage.saveUser(authResponse.user);
      return Right(authResponse);
    } on DioException catch (e) {
      return Left(e.message ?? 'Google login failed. Please try again.');
    } catch (e) {
      return Left('An unexpected error occurred. Please try again.');
    }
  }

  /// Get the currently authenticated user's profile
  Future<ProfileResult> getProfile() async {
    try {
      final response = await _apiClient.get('/auth/profile');
      final user = UserModel.fromJson(response.data['user'] as Map<String, dynamic>? ?? {});
      return Right(user);
    } on DioException catch (e) {
      return Left(e.message ?? 'Failed to load profile.');
    } catch (e) {
      return Left('An unexpected error occurred.');
    }
  }

  /// Logout the current user
  Future<Either<String, String>> logout() async {
    try {
      await _apiClient.post('/auth/logout');
      _apiClient.setAuthToken(null);
      _storage.clearAuth();
      return const Right('Logged out successfully.');
    } on DioException catch (e) {
      // Clear token even if the API call fails
      _apiClient.setAuthToken(null);
      _storage.clearAuth();
      return Left(e.message ?? 'Logout failed.');
    } catch (e) {
      _apiClient.setAuthToken(null);
      _storage.clearAuth();
      return Left('An unexpected error occurred.');
    }
  }
}
