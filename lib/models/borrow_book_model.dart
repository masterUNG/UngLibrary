// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BorrowBookModel {
  final String docUser;
  final Timestamp startDate;
  final Timestamp endDate;
  final bool status;
  BorrowBookModel({
    required this.docUser,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docUser': docUser,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }

  factory BorrowBookModel.fromMap(Map<String, dynamic> map) {
    return BorrowBookModel(
      docUser: (map['docUser'] ?? '') as String,
      startDate: (map['startDate'] ),
      endDate: (map['endDate'] ),
      status: (map['status'] ?? false) as bool,
    );
  }

  factory BorrowBookModel.fromJson(String source) => BorrowBookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
