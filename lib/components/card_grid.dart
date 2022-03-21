/*
 * Copyright (c) 2022, Oracle and/or its affiliates.
 * Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
 */

import 'package:flutter/material.dart';
import 'package:ocefluttergallerysample/components/item_image.dart';
import 'package:ocefluttergallerysample/models/categoryListItemModel.dart';
import 'package:ocefluttergallerysample/networking/services.dart';
import 'package:ocefluttergallerysample/utils/constants.dart';
import '../screens/image_grid.dart';

class CardGrid extends StatefulWidget {
  // Constructor that accepts the CategoryListItemModel object that represents the category
  CardGrid({@required this.category});

  final CategoryListItemModel category;

  @override
  _CardGridState createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  String exception;
  int totalResults = 0;
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
          await services.fetchItemsForCategory(categoryId, true);
      totalResults = categoryItems['totalResults'];
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
    return (!dataFetched)
        ?
        // By default, show a loading spinner.
        Center(child: CircularProgressIndicator())
        : GestureDetector(
            onTap: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => ImageGrid(
                    category: widget.category,
                  ),
                ),
              );
            },
            child: Column(
              children: <Widget>[
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 5.0,
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                            child: ItemImage(
                                itemId: items[0]['id'], height: 200.0)),
                        SizedBox(height: kCardGridSpacing),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: ItemImage(
                                    itemId: items[1]['id'], height: 100.0)),
                            SizedBox(width: kCardGridSpacing),
                            Expanded(
                                child: ItemImage(
                                    itemId: items[2]['id'], height: 100.0)),
                            SizedBox(width: kCardGridSpacing),
                            Expanded(
                                child: ItemImage(
                                    itemId: items[3]['id'], height: 100.0)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  widget.category.name,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$totalResults Photos",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
          );
  }
}
