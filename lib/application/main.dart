import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/state/view_state.dart';
import '../view/repository_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(GitHubApp());
}

class GitHubApp extends StatelessWidget {
  final ViewState userState = ViewState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<ViewState>(
        create: (_) => ViewState(),
        child: RepositoryScreen(),
      )
    );
  }
}