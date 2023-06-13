import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
        title: Text(widget.repository.fullName,
            style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(widget.repository.owner.avatarUrl),
                ),

                Text(
                  widget.repository.name,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                Text(
                  widget.repository.description.toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.star),
                    title: Text(widget.repository.stargazersCount.toString()),
                    onTap: () {
                      _openUrl('${widget.repository.htmlUrl}/stargazers');
                    },
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.remove_red_eye),
                    title: Text(widget.repository.watchersCount.toString()),
                    onTap: () {
                      _openUrl('${widget.repository.htmlUrl}/watchers');
                    },
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.call_split),
                    title: Text(widget.repository.forksCount.toString()),
                    onTap: () {
                      _openUrl('${widget.repository.htmlUrl}/network/members');
                    },
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.radio_button_checked),
                    title: Text(widget.repository.openIssuesCount.toString()),
                    onTap: () {
                      _openUrl('${widget.repository.htmlUrl}/issues');
                    },
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.data_object),
                    title: Text(widget.repository.language.toString()),
                    onTap: () {
                      _openUrl(widget.repository.languagesUrl);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openUrl(String url) async {
    launchUrl(Uri.parse(url));
  }
}
