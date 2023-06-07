import 'package:flutter/material.dart';
import '../entity/search_repository.dart';
import '../network/api_client.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _apiClient = APIClient();

  bool _searchBoolean = false;

  SearchRepository searchRepository = SearchRepository(
    totalCount: 0,
    incompleteResults: false,
    items: [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: !_searchBoolean ?
        Text(widget.title, style: const TextStyle(color: Colors.white)) :
        Padding(padding: const EdgeInsets.all(5), child: _searchTextField()),
          actions: !_searchBoolean ? [_searchIcon()] : [_clearIcon()]
      ),
      body: ListView.builder(
        itemCount: searchRepository.items.length,
        itemBuilder: (BuildContext context, int index) {
          return _githubItem(searchRepository.items[index].name);
        },
      ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      onSubmitted: (String value) { fetchSearchRepository(value); },
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

  Widget _searchIcon() {
    return IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {
      setState(() {
        _searchBoolean = true;
      });
    });
  }

  Widget _clearIcon() {
    return IconButton(icon: const Icon(Icons.clear, color: Colors.white), onPressed: () {
      setState(() {
        _searchBoolean = false;
      });
    });
  }

  Widget _githubItem(String title) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        onTap: () {
          print("onTap called.");
        },
      ),
    );
  }

  Future<void> fetchSearchRepository(String q) async {
    try {
      final data = await _apiClient.getSearchRepository(q);
      setState(() => searchRepository = data);
    } catch (e) {
      print('エラー: $e');
    }
  }
}
