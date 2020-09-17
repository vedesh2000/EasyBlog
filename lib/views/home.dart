import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterblog/views/create_blog.dart';
import 'package:flutterblog/services/crud.dart';

import 'blog.dart';

class HomePage extends StatefulWidget {
@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();


  Stream blogsStream;

  Widget BlogsList() {
    return Container(
      child: blogsStream != null
          ? Column(
        children: <Widget>[
          StreamBuilder(
            stream: blogsStream,
            builder: (context, snapshot) {
              return Expanded(child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: snapshot.data.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BlogsTile(
                      authorName: snapshot
                          .data.documents[index].data['authorName'],
                      title: snapshot.data.documents[index].data["title"],
                      description:
                      snapshot.data.documents[index].data['desc'],
                      imgUrl:
                      snapshot.data.documents[index].data['imgUrl'],
                      content: snapshot.data.documents[index].data['content'],
                    );
                  })
              );
            },
          )
        ],
      )
          : Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        blogsStream = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Easy",
              style: TextStyle(fontSize: 22, color: Colors.white70),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BlogsList(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton.extended(
              backgroundColor: const Color(0xFF00BCD4),
              foregroundColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              icon: Icon(Icons.add),
              label: Text('Create New Blog'),
            )
          ],
        ),
      ),
    );
  }
}
class BlogsTile extends StatelessWidget {
  String imgUrl, title, description, authorName,content;
  BlogsTile(
      {@required this.imgUrl,
        @required this.title,
        @required this.description,
        @required this.authorName,
        @required this.content
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              width: MediaQuery.of(context).size.width,
             fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 2000,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(authorName),
                FlatButton.icon(
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SecondRoute(imgUrl:imgUrl, content: content,)));
                  },
                  icon: Icon(Icons.add, size: 18),
                  label: Text("Click to View"),
                )
                /*GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateBlog()));
                  },
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }
}