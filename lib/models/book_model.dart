import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookModel {
  final String cover;
  final String isbnNumber;
  final String publisher;
  final String author;
  final String bookCatetory;
  final String bookCode;
  final String detail;
  final String numberOfPage;
  final String title;
  final String yearOfImport;
  BookModel({
    required this.cover,
    required this.isbnNumber,
    required this.publisher,
    required this.author,
    required this.bookCatetory,
    required this.bookCode,
    required this.detail,
    required this.numberOfPage,
    required this.title,
    required this.yearOfImport,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cover': cover,
      'ISBN Number': isbnNumber,
      'Publisher': publisher,
      'author': author,
      'book category': bookCatetory,
      'book code': bookCode,
      'details': detail,
      'number of pages': numberOfPage,
      'title': title,
      'year of import': yearOfImport,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      cover: (map['cover'] ?? '') as String,
      isbnNumber: (map['ISBN Number'] ?? '') as String,
      publisher: (map['Publisher'] ?? '') as String,
      author: (map['author'] ?? '') as String,
      bookCatetory: (map['book category'] ?? '') as String,
      bookCode: (map['book code'] ?? '') as String,
      detail: (map['details'] ?? '') as String,
      numberOfPage: (map['number of pages'] ?? '') as String,
      title: (map['title'] ?? '') as String,
      yearOfImport: (map['year of import'] ?? '') as String,
    );
  }

  factory BookModel.fromJson(String source) => BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
