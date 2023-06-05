import 'package:flutter/material.dart';
import '../network/api_client.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final apiClient = APIClient();

  Future<void> fetchSearchRepository() async {
    try {
      final exampleData = await apiClient.getSearchRepository("flutter");
      final totalCount = exampleData.totalCount;
      print('$totalCount');
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget _searchTextField() {
    return TextField(
      onSubmitted: (String value) { print("$value"); },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)
        ),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  var list = ["メッセージ", "メッセージ", "メッセージ", "メッセージ", "メッセージ",];

  bool _searchBoolean = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: !_searchBoolean ?
        Text(widget.title, style: const TextStyle(color: Colors.white)) :
        Padding(padding: const EdgeInsets.all(5), child: _searchTextField()),
          actions: !_searchBoolean ? [
            IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {
              setState(() {
                _searchBoolean = true;
              });
            })
          ] : [
            IconButton(icon: const Icon(Icons.clear, color: Colors.white), onPressed: () {
              setState(() {
                _searchBoolean = false;
              });
            })
          ]
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index >= list.length) {
            list.addAll(["メッセージ","メッセージ","メッセージ","メッセージ",]);
          }
          return _messageItem(list[index]);
        },
      ),
    );
  }

  Widget _messageItem(String title) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        onTap: () {
          print("onTap called.");
        },
      ),
    );
  }
}
