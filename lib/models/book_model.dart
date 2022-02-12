import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookModel {
  final String name;
  final String cover;
  BookModel({
    required this.name,
    required this.cover,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cover': cover,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      name: (map['name'] ?? '') as String,
      cover: (map['cover'] ?? '') as String,
    );
  }

  factory BookModel.fromJson(String source) => BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
