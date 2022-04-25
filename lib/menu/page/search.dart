import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../network.dart';
import '../../post.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Post> _posts = <Post>[];
  List<Post> _postsDisplay = <Post>[];

  bool _isLoading = true;

  @override
  void initState() {
    fetchPost().then((value) {
      setState(() {
        _isLoading = false;
        _posts.addAll(value);
        _postsDisplay = _posts;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pencarian Barang')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (!_isLoading) {
            return index == 0 ? _searchBar() : _listItem(index - 1);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        itemCount: _postsDisplay.length + 1,
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.search),
            hintText: 'Cari Barang',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _postsDisplay = _posts.where((post) {
              var postTitle = post.title!.toLowerCase();
              return postTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
        child: Padding(
      padding: EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_postsDisplay[index].title.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(_postsDisplay[index].body.toString(),
              style: TextStyle(color: Colors.grey))
        ],
      ),
    ));
  }
}
