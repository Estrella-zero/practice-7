import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('关于')),
      body: const Center(child: Text('app_skeleton v1.0\n第7课作业：滚动列表与多页面导航')),
    );
  }
}