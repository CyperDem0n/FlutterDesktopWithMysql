// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int? user_id;
  String? email;
  String? username;
  String? password;

  User({this.user_id, this.email, this.username, this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'email': email,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      user_id: map['user_id'] != null ? map['user_id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }
}
