import 'package:flutter/material.dart';

class LocalDatabasePage extends StatelessWidget {
  const LocalDatabasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Database'),
      ),
      body: const Center(
        child: Text('Local Database Page'),
      ),
    );
  }
}
