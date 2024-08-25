import 'dart:async';
import 'dart:convert';

import 'package:Users/core/endpoint.dart';
import 'package:Users/features/users/data/models/users_model.dart';
import 'package:http/http.dart' as http;


List<UserModel> filterUsers(List<UserModel> users, String query) {
  final lowerCaseQuery = query.toLowerCase();
  return users.where((user) => user.name.toLowerCase().contains(lowerCaseQuery)).toList();
}

 Future<List<UserModel>> fetchUsers() async {
  final client = http.Client();
  List<UserModel> users = [];
  try {
    final response = await client
        .get(Uri.parse(Endpoints.users));

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        UserModel user =
            UserModel.fromJson(result[i] as Map<String, dynamic>);
        users.add(user);
      }
    } else {
      throw Exception('Failed to load users');
    }
  } catch (e) {
    throw Exception('Failed to load users: $e');
  } finally {
    client.close();
  }
  return users;
}