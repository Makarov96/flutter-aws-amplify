// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

BookModelTwo bookModelFromJson(String str) =>
    BookModelTwo.fromJson(json.decode(str));

String bookModelToJson(BookModelTwo data) => json.encode(data.toJson());

class BookModelTwo {
  BookModelTwo({
    this.author,
    this.bookName,
  });

  String author;
  String bookName;

  factory BookModelTwo.fromJson(Map<String, dynamic> json) => BookModelTwo(
        author: json["author"],
        bookName: json["book_name"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "book_name": bookName,
      };
}
