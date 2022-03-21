/*
 * Copyright (c) 2022, Oracle and/or its affiliates.
 * Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
 */

import 'package:flutter/material.dart';
import 'package:ocefluttergallerysample/components/card_grid.dart';
import 'package:ocefluttergallerysample/components/screen_layout.dart';
import 'package:ocefluttergallerysample/models/categoryListItemModel.dart';
import 'package:ocefluttergallerysample/networking/services.dart';
import 'package:ocefluttergallerysample/utils/constants.dart';
import 'package:ocefluttergallerysample/utils/util.dart';

enum MenuOption { ABOUT, CONTACT_US }

//This class renders the initial topics screen.
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String exception;
  List<dynamic> items = [];
  List<CategoryListItemModel> categories = [];

  @override
  void initState() {
    super.initState();
    if (mounted) fetchData();
  }

  // Makes API call to fetch the home page details. For each topic in the list that comes back, fetch the
  // topic. Render as soon as each one is fetched.
  Future<void> fetchData() async {
    final Services services = Services();
    try {
      List<String> taxonomyIdArray = await services.fetchTaxonomies();
      // For each taxonomy, fetch the categories and append them to an array
      for (var taxonomyId in taxonomyIdArray) {
        List<dynamic> data = await services.fetchCategories(taxonomyId);
        for (var categoryData in data) {
          categories.add(CategoryListItemModel.fromJson(categoryData));
        }
        setState(() {
          categories = categories;
        });
      }
    } catch (exception) {
      setState(() => this.exception = exception.toString());
      print(exception.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    int numOfColumns = getNumColumns(context);
    double aspectRatio = getAspectRatio(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Gallery"),
          backgroundColor: kActionbarColor,
        ),
        body: ScreenLayout(
          exception: exception,
          loading: (categories.length == 0),
          body: GridView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            padding: const EdgeInsets.all(kDefaultPadding),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: aspectRatio,
              mainAxisSpacing: kGridSpacing,
              crossAxisSpacing: kGridSpacing,
              crossAxisCount: numOfColumns,
            ),
            itemBuilder: (BuildContext context, int index) {
              return CardGrid(category: categories[index]);
            },
          ),
        ));
  }
}
