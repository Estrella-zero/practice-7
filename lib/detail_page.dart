import 'package:flutter/material.dart';
import 'book.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as Book;

    return Scaffold(
      appBar: AppBar(title: Text(book.title)), 
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            _row('编号', book.id),
            _row('书名', book.title),
            _row('作者', book.author),
            _row('分类', book.category),
            _row('评分', '★' * book.rating), 
            _row('借阅次数', '${book.borrowCount}次'),
            _row('月份', book.month),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('返回'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text('$label：$value', style: const TextStyle(fontSize: 16)),
    );
  }
}