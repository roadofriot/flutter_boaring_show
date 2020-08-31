import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'src/article.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Article Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        // this is for refreshing your content of list view
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            _articles.removeAt(0); //this will remove your first article from list
          });
          return ;
        },
        child: ListView(
          children: _articles.map(_builtItem).toList(),
        ),
      ),
    );
  }

  Widget _builtItem(Article article) {
    return Padding(
      key: UniqueKey(), //this UniqueKey helps to close all article  which is opened

      padding: const EdgeInsets.all(15.0),
      child: ExpansionTile(
        title: Text(
          article.text,
          style: TextStyle(fontSize: 24),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${article.commentsCount}  comments"),
              IconButton(
                  icon: Icon(Icons.launch),
                  onPressed: () async {
                    final fakeUrl = "http://${article.domain}";
                    if (await canLaunch(fakeUrl)) {
                      launch(
                        fakeUrl,
                      );
                    }
                  })
            ],
          )
        ],
      ),
    );
  }
}
