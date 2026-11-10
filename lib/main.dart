import 'package:flutter/material.dart';
import 'list_page.dart';
import 'detail_page.dart';
import 'home_page.dart'; 

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Skeleton',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      
      routes: {
        '/': (_) => const HomePage(),        
        '/list': (_) => const ListPage(),    
        '/detail': (_) => const DetailPage(),
      },
    );
  }
}