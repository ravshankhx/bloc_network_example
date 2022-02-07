import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserProvider {
  Future<List<User>> getUser() async {
    var uri =Uri.http("jsonplaceholder.typicode.com", "/users");
    final response = await http.get(uri,headers: {});
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body);
      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Error fetching users");
    }
  }
}