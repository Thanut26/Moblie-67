import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Librarypage'),
      ),
      body: const Center(
        child: Text("Library Page"),
      ),
    );
  }
}
