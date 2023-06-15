import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/state/view_state.dart';
import 'package:flutter_engineer_codecheck/view/indicator_screen.dart';
import 'package:flutter_engineer_codecheck/view/repository_detail_screen.dart';
import '../entity/search_repository.dart';
import 'package:provider/provider.dart';

class RepositoryScreen extends StatefulWidget {
  @override
  State<RepositoryScreen> createState() => _RepositoryScreenState();
}

class _RepositoryScreenState extends State<RepositoryScreen> {
  @override
  Widget build(BuildContext context) {

    final ViewState viewState = Provider.of<ViewState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: !viewState.searchBoolean ?
        const Text("GitHub Repository Search", style: TextStyle(color: Colors.white)) :
        Padding(padding: const EdgeInsets.all(5), child: _searchTextField()),
          actions: !viewState.searchBoolean ? [_searchIcon()] : [_clearIcon()]
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ListView.builder(
            itemCount: viewState.searchRepository.items.length,
            itemBuilder: (BuildContext context, int index) {
              return _githubItem(viewState.searchRepository.items[index]);
            },
          ),
          IndicatorScreen(visible: viewState.visibleIndicator)
        ],
      ),
    );
  }

  Widget _searchTextField() {
    final ViewState viewState = Provider.of<ViewState>(context);

    return TextField(
      onSubmitted: (String value) async {
        try {
          // ローディングを表示
          viewState.showIndicator();
          // GitHubのリポジトリ検索結果を取得
          await viewState.fetchSearchRepository(value);
          // ローディングを非表示
          viewState.hideIndicator();
        } catch (error) {
          // ローディングを非表示
          viewState.hideIndicator();
          // エラーが発生した場合はダイアログを表示
          showDialog<void>(context: context, builder: (_) {
            return AlertDialog(title: Text(error.toString()));
          });
        }
      },
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
    final ViewState viewState = Provider.of<ViewState>(context);

    return IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {
      viewState.enableSearchMode();
    });
  }

  Widget _clearIcon() {
    final ViewState viewState = Provider.of<ViewState>(context);

    return IconButton(icon: const Icon(Icons.clear, color: Colors.white), onPressed: () {
      viewState.disableSearchMode();
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
}
