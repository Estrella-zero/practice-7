import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; 
import 'book.dart';
import 'widgets/book_tile.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _visibleCount = 20;
  Future<List<Book>> _loadBooks() async {
    final text = await rootBundle.loadString('assets/books.json');
    final List<dynamic> list = jsonDecode(text);
    return list.map((j) => Book.fromJson(j)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(title: Text(category ?? '书籍列表')), 
      body: FutureBuilder<List<Book>>(
        future: _loadBooks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var books = snapshot.data!;
          if(category != null){
            books = books.where((b) => b.category == category).toList();
          }
          final visible = books.take(_visibleCount).toList();
          final hasMore = books.length > visible.length;

          return ListView.builder(
            itemCount: visible.length + (hasMore ? 1 : 0),
            itemBuilder: (context, i) {
              if (i == visible.length) {
                return Center(
                  child: TextButton(
                    onPressed: () => setState(() => _visibleCount += 20), 
                    child: const Text('加载更多'),
                  ),
                );
              }
              final book = visible[i];
              return BookTile(
                book: book,
                onTap: (b) => Navigator.pushNamed(context, '/detail', arguments: b),
                onLongPress: () => _showFilterSheet(context), 
              );
            },
          );
        },
      ),
    );
  }
    void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => ListTile(
        leading: const Icon(Icons.filter_alt),
        title: const Text('仅看高借阅量'),
        onTap: () {
          Navigator.pop(sheetContext); 
          Navigator.pop(context, '仅看高借阅量'); 
        },
      ),
    );
  }
}
