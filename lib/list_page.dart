import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; 
import 'book.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  // 异步加载 assets/books.json 并解析成 List<Book>
  Future<List<Book>> _loadBooks() async {
    final text = await rootBundle.loadString('assets/books.json');
    final List<dynamic> list = jsonDecode(text);
    return list.map((j) => Book.fromJson(j)).take(20).toList(); // 只取前 20 条
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('书籍列表')),
      // 异步数据用 FutureBuilder：加载中显示转圈，完成后显示列表
      body: FutureBuilder<List<Book>>(
        future: _loadBooks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final books = snapshot.data!;
          return ListView.builder(
            itemCount: books.length, // 总条数
            itemBuilder: (context, i) {
              // 只构建滚入视口的项
              final book = books[i];
              return ListTile(
                leading: const Icon(Icons.menu_book),
                title: Text(book.title),
                subtitle: Text('${book.author} · ${book.category}'),
                trailing: Text('${book.borrowCount}次'),
              );
            },
          );
        },
      ),
    );
  }
}