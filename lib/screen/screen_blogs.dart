import 'dart:async';

import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/book_model.dart';
import '../models/BookModel.dart';

class ScreenBlog extends StatelessWidget {
  const ScreenBlog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs Screen'),
      ),
      body: ScreenBlogLayout(),
    );
  }
}

class ScreenBlogLayout extends StatefulWidget {
  ScreenBlogLayout({Key key}) : super(key: key);

  @override
  _ScreenBlogLayoutState createState() => _ScreenBlogLayoutState();
}

class _ScreenBlogLayoutState extends State<ScreenBlogLayout> {
  BookModelTwo result;

  List<BookModel> book = [];
  @override
  void initState() {
    super.initState();
  }

  runQueries() async {
    book.clear();
    final reuslt = await Amplify.DataStore.query(BookModel.classType);
    book.addAll(reuslt);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: createBook(),
          builder:
              (BuildContext context, AsyncSnapshot<BookModelTwo> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Container(
                  child: Text('Se ha creado el libro'),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        RaisedButton(
          child: Text('Agregar libro'),
          onPressed: () async {
            final book = BookModel(author: 'sdfsdfsd', book_name: 'sdfsdfsfsd');

            await Amplify.DataStore.save(book);
            runQueries();
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: book.length,
            itemBuilder: (_, i) => Text(book[i].author),
          ),
        )
      ],
    );
  }

  Future<BookModelTwo> createBook() async {
    try {
      final body = bookModelToJson(
        BookModelTwo(
            author: 'Frank Espinoza',
            bookName: 'Los secretos que nadie te conto'),
      );
      final response = await http.post(
        'https://o5ibptlvt8.execute-api.us-east-1.amazonaws.com/dev/items',
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return bookModelFromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (_) {
      throw Exception();
    }
  }
}
