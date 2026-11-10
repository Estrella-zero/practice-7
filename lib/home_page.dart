import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; 
import 'book.dart';
import 'widgets/category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _filter;

  Future<List<String>> _loadCategories() async {
    final text = await rootBundle.loadString('assets/books.json');
    final List<dynamic> list = jsonDecode(text);
    final books = list.map((j) => Book.fromJson(j)).toList();
    return books.map((b) => b.category).toSet().toList(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('首页'),
            if (_filter != null)
              Text(_filter!, style: const TextStyle(fontSize: 12)),
          ],
        ),
        actions:[
          IconButton(
            icon:const Icon(Icons.info_outline),
            onPressed:() => Navigator.pushNamed(context,'/about'),
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: _loadCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final categories = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: categories.length,
            itemBuilder: (context, i) {
              final category = categories[i];
              return CategoryCard(
                category: category,
                onTap: () async {                     
                  final result = await Navigator.pushNamed(context, '/list', arguments: category);
                  if (result != null && mounted) {
                    setState(() => _filter = result as String);
                  }
                },
              );
            },
            
          );
        },
      ),
    );
  }
}