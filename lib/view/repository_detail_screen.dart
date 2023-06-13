import 'package:flutter/material.dart';
import '../entity/search_repository.dart';

class RepositoryDetailScreen extends StatefulWidget {
  const RepositoryDetailScreen({super.key, required this.repository});

  final Item repository;

  @override
  State<RepositoryDetailScreen> createState() => _RepositoryDetailScreenState();
}

class _RepositoryDetailScreenState extends State<RepositoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.repository.fullName, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(widget.repository.fullName),
      ),
    );
  }
}