/*
 * Copyright (c) 2022, Oracle and/or its affiliates.
 * Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
 */

import 'package:flutter/material.dart';
import 'package:ocefluttergallerysample/components/item_image.dart';
import 'package:ocefluttergallerysample/components/screen_layout.dart';
import 'package:ocefluttergallerysample/utils/constants.dart';

class ImagePager extends StatefulWidget {
  // Constructor that accepts the articleListItemModel
  ImagePager({@required this.items, this.currentIndex});

  final List<dynamic> items;
  final int currentIndex;
  @override
  _ImagePagerState createState() => _ImagePagerState();
}

class _ImagePagerState extends State<ImagePager> {
  List<String> imageUrls = [];
  bool dataFetched = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kActionbarColor,
      ),
      body: ScreenLayout(
        exception: null,
        loading: false,
        body: Container(
          color: Colors.black,
          padding: EdgeInsets.all(8.0),
          child: PageView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: PageController(
                  initialPage: widget.currentIndex,
                  viewportFraction: 0.9999, //hack to preload the pages
                ),
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ItemImage(
                          itemId: widget.items[index]['id'],
                          fit: BoxFit.contain,
                          thumbnail: false,
                        ),
                      ),
                    ],
                  );
                }),
        ),
      ),
    );
  }
}
