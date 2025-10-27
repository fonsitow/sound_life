import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Auth {
  final String id;
  final String email;
  Auth({required this.id, required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'email': email};
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(id: map['id'] as String, email: map['email'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) =>
      Auth.fromMap(json.decode(source) as Map<String, dynamic>);
}
