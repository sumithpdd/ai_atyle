import 'package:flutter/material.dart';

class DiscoverStyleScreen extends StatelessWidget {
  const DiscoverStyleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover Your Style')),
      body: const Center(
        child: Text('Discover your style flow coming soon!'),
      ),
    );
  }
}
