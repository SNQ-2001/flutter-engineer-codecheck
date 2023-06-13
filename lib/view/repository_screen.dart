import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/view/indicator_screen.dart';
import 'package:flutter_engineer_codecheck/view/repository_detail_screen.dart';
import '../entity/search_repository.dart';
import '../network/api_client.dart';

class RepositoryScreen extends StatefulWidget {
  const RepositoryScreen({super.key, required this.title});

  final String title;

  @override
  State<RepositoryScreen> createState() => _RepositoryScreenState();
}

class _RepositoryScreenState extends State<RepositoryScreen> {
  final _apiClient = APIClient();

  bool _searchBoolean = false;

  bool visibleIndicator = false;

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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ListView.builder(
            itemCount: searchRepository.items.length,
            itemBuilder: (BuildContext context, int index) {
              return _githubItem(searchRepository.items[index]);
            },
          ),
          IndicatorScreen(visible: visibleIndicator)
        ],
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

  Widget _githubItem(Item repository) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(repository.owner.avatarUrl),
        ),
        title: Text(
          repository.fullName,
          style: const TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500)
        ),
        subtitle: Text(
            repository.owner.login,
            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal)
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            // （2） 実際に表示するページ(ウィジェット)を指定する
              builder: (context) => RepositoryDetailScreen(repository: repository)
          ));
        },
      ),
    );
  }

  Future<void> fetchSearchRepository(String q) async {
    try {
      // ローディングを表示
      setState(() { visibleIndicator = true; });
      // GitHubのリポジトリ検索結果を取得
      final data = await _apiClient.getSearchRepository(q);
      setState(() => searchRepository = data);
      // ローディングを非表示
      setState(() { visibleIndicator = false; });
    } catch (error) {
      // ローディングを非表示
      setState(() { visibleIndicator = false; });
      // エラーが発生した場合はダイアログを表示
      showDialog<void>(context: context, builder: (_) {
        return AlertDialog(title: Text(error.toString()));
      });
    }
  }
}
