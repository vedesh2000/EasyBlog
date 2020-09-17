import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterblog/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:random_string/random_string.dart';

class SecondRoute extends StatelessWidget {
  String imgUrl,content;
  SecondRoute(
      {@required this.imgUrl,
        @required this.content,
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog" ,  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500 , color: Colors.deepOrangeAccent),),
      ),
      body: Center(
        child: SingleChildScrollView(
          //margin: EdgeInsets.only(bottom: 16),
          //height: 150,
          child: Stack(
              children: <Widget>[
          Column(
            children: <Widget>[
              ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              ),Container(
                child: Text(
                  content,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
    ]
        ),
      ),
    )
    );
  }
}