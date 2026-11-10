import 'package:flutter/material.dart';
import '../book.dart';

class BookTile extends StatelessWidget {
  final Book book;                       
  final void Function(Book) onTap;       
  final VoidCallback? onLongPress;       
  const BookTile({super.key, required this.book, required this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.menu_book),
      title: Text(book.title),
      subtitle: Text('${book.author} · ${book.category}'),
      trailing: Text('${book.borrowCount}次'),
      onTap: () => onTap(book),
      onLongPress: onLongPress,
    );
  }
}