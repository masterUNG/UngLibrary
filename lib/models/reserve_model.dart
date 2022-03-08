// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReserveModel {
  final String cover;
  final String docBook;
  final Timestamp endDate;
  final String nameBook;
  final bool status;
  ReserveModel({
    required this.cover,
    required this.docBook,
    required this.endDate,
    required this.nameBook,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cover': cover,
      'docBook': docBook,
      'endDate': endDate,
      'nameBook': nameBook,
      'status': status,
    };
  }

  factory ReserveModel.fromMap(Map<String, dynamic> map) {
    return ReserveModel(
      cover: (map['cover'] ?? '') as String,
      docBook: (map['docBook'] ?? '') as String,
      endDate: (map['endDate']),
      nameBook: (map['nameBook'] ?? '') as String,
      status: (map['status'] ?? false) as bool,
    );
  }

  factory ReserveModel.fromJson(String source) => ReserveModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
