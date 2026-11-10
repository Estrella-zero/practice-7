import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; 
import 'book.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  Future<List<Book>> _loadBooks() async {
    final text = await rootBundle.loadString('assets/books.json');
    final List<dynamic> list = jsonDecode(text);
    return list.map((j) => Book.fromJson(j)).take(20).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('书籍列表')),
      body: FutureBuilder<List<Book>>(
        future: _loadBooks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final books = snapshot.data!;
          return ListView.builder(
            itemCount: books.length, 
            itemBuilder: (context, i) {
              final book = books[i];
              return ListTile(
                leading: const Icon(Icons.menu_book),
                title: Text(book.title),
                subtitle: Text('${book.author} · ${book.category}'),
                trailing: Text('${book.borrowCount}次'),
                onTap: () => Navigator.pushNamed(context, '/detail', arguments: book),
              );
            },
          );
        },
      ),
    );
  }
}