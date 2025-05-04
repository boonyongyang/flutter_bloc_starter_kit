import 'package:flutter/material.dart';

class LocalizationPage extends StatelessWidget {
  const LocalizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localization'),
      ),
      body: const Center(
        child: Text('Localization Page'),
      ),
    );
  }
}
