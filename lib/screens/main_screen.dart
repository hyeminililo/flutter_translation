import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'a',
            style: TextStyle(fontSize: 50),
          ),
          const Text(
            'b',
            style: TextStyle(fontSize: 50),
          ),
          const Text(
            'c',
            style: TextStyle(fontSize: 50),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('translation'))
        ],
      ),
    );
  }
}
