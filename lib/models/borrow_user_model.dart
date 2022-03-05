// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BorrowUserModel {
  final String docBook;
  final Timestamp startDate;
  final Timestamp endDate;
  final bool status;
  BorrowUserModel({
    required this.docBook,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docBook': docBook,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }

  factory BorrowUserModel.fromMap(Map<String, dynamic> map) {
    return BorrowUserModel(
      docBook: (map['docBook'] ?? '') as String,
      startDate: (map['startDate']),
      endDate: (map['endDate']),
      status: (map['status'] ?? false) as bool,
    );
  }

  factory BorrowUserModel.fromJson(String source) => BorrowUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
