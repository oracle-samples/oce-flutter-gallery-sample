/*
 * Copyright (c) 2022, Oracle and/or its affiliates.
 * Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
 */

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ocefluttergallerysample/components/item_image.dart';
import 'package:ocefluttergallerysample/components/screen_layout.dart';
import 'package:ocefluttergallerysample/models/categoryListItemModel.dart';
import 'package:ocefluttergallerysample/networking/services.dart';
import 'package:ocefluttergallerysample/screens/image_pager.dart';
import 'package:ocefluttergallerysample/utils/constants.dart';
import 'package:ocefluttergallerysample/utils/util.dart';

class ImageGrid extends StatefulWidget {
  // Constructor that accepts the articleListItemModel
  ImageGrid({@required this.category});

  final CategoryListItemModel category;

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  String exception;
  List<dynamic> items = [];
  bool dataFetched = false;

  @override
  void initState() {
    super.initState();
    if (mounted) fetchData();
  }

// Makes API call to fetch the home page details. For each topic in the list that comes back, fetch the
// topic. Render as soon as each one is fetched.
  Future<void> fetchData() async {
    final Services services = Services();

    String categoryId = widget.category.id;
    try {
      dynamic categoryItems =
          await services.fetchItemsForCategory(categoryId, false);
      items = categoryItems['items'];
      setState(() {
        dataFetched = true;
      });
    } catch (exception) {
      setState(() {
        this.exception = exception.toString();
      });
      print(exception.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final int numOfColumns = getNumColumnsForImageGrid(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: kActionbarColor,
      ),
      body: ScreenLayout(
        exception: exception,
        loading: (items.length == 0),
        body: MasonryGridView.count(
          crossAxisCount: numOfColumns,
          itemCount: items.length,
          padding: const EdgeInsets.all(kGridSpacing),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => ImagePager(
                      items: items,
                      currentIndex: index,
                    ),
                  ),
                );
              },
              child: ItemImage(itemId: items[index]['id']),
            );
          },
          mainAxisSpacing: kGridSpacing,
          crossAxisSpacing: kGridSpacing,
        ),
      ),
    );
  }
}
