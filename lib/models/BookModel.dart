/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the BookModel type in your schema. */
@immutable
class BookModel extends Model {
  static const classType = const _BookModelModelType();
  final String id;
  final String author;
  final String book_name;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const BookModel._internal({@required this.id, this.author, this.book_name});

  factory BookModel({String id, String author, String book_name}) {
    return BookModel._internal(
        id: id == null ? UUID.getUUID() : id,
        author: author,
        book_name: book_name);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookModel &&
        id == other.id &&
        author == other.author &&
        book_name == other.book_name;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("BookModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("author=" + "$author" + ", ");
    buffer.write("book_name=" + "$book_name");
    buffer.write("}");

    return buffer.toString();
  }

  BookModel copyWith({String id, String author, String book_name}) {
    return BookModel(
        id: id ?? this.id,
        author: author ?? this.author,
        book_name: book_name ?? this.book_name);
  }

  BookModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = json['author'],
        book_name = json['book_name'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'author': author, 'book_name': book_name};

  static final QueryField ID = QueryField(fieldName: "bookModel.id");
  static final QueryField AUTHOR = QueryField(fieldName: "author");
  static final QueryField BOOK_NAME = QueryField(fieldName: "book_name");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "BookModel";
    modelSchemaDefinition.pluralName = "BookModels";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: BookModel.AUTHOR,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: BookModel.BOOK_NAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _BookModelModelType extends ModelType<BookModel> {
  const _BookModelModelType();

  @override
  BookModel fromJson(Map<String, dynamic> jsonData) {
    return BookModel.fromJson(jsonData);
  }
}
