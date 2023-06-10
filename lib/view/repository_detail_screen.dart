import 'package:flutter/material.dart';

class RepositoryDetailScreen extends StatefulWidget {
  const RepositoryDetailScreen({super.key, required this.repositoryName});

  final String repositoryName;

  @override
  State<RepositoryDetailScreen> createState() => _RepositoryDetailScreenState();
}

class _RepositoryDetailScreenState extends State<RepositoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.repositoryName, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(widget.repositoryName),
      ),
    );
  }
}