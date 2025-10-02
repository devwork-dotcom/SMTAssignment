import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class AuthService {
  static const String baseUrl = 'https://api.restful-api.dev';
  static final Uuid _uuid = Uuid();

  static Future<List<dynamic>> getAllUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/objects'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
  }) async
  {
    try {
      final existingUser = await findUserByEmail(email);
      if (existingUser != null) {
        throw Exception('User already exists with this email');
      }

      final uuid = _uuid.v4();
      final userData = {
        'uuid': uuid,
        'name': name,
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/objects'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        Map<String, dynamic> userMap = {};

        if (responseData is Map<String, dynamic>) {
          userMap = Map<String, dynamic>.from(responseData);
        } else {
          userMap = {
            'uuid': uuid,
            'name': name,
            'email': email,
            'isVerified': false,
            'createdAt': DateTime.now().toIso8601String(),
          };
        }

        userMap.remove('password');

        return {
          'success': true,
          'message': 'User registered successfully',
          'data': userMap,
        };
      } else {
        throw Exception('Failed to create user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }


  static Future<Map<String, dynamic>?> findUserByEmail(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/objects?email=$email'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List && data.isNotEmpty) {
          return Map<String, dynamic>.from(data.first);
        }
        return null;
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Error finding user: ${response.statusCode}');
      }
    } catch (e) {
      return null;
    }
  }


  static Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async
  {
    try {
      final user = await findUserByEmail(email);

      if (user == null) {
        throw Exception('Invalid email or password');
      }

      if (user['password'] != password) {
        throw Exception('Invalid email or password');
      }

      final userWithoutPassword = Map<String, dynamic>.from(user);
      userWithoutPassword.remove('password');

      return {
        'success': true,
        'message': 'Login successful',
        'data': userWithoutPassword,
      };
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }


  static Future<List<dynamic>> getAllObjects() async {
    final response = await http.get(
      Uri.parse('$baseUrl/objects'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load objects: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getObjectsByIds(List<String> ids) async {
    final idString = ids.join(',');
    final response = await http.get(
      Uri.parse('$baseUrl/objects?ids=$idString'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load objects by IDs: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getObjectById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/objects/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Object with ID $id not found');
    } else {
      throw Exception('Failed to load object: ${response.statusCode}');
    }
  }


}