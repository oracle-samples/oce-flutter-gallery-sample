/*
 * Copyright (c) 2022, Oracle and/or its affiliates.
 * Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
 */

//Object that encapsulates details for each item in the topic list for the homepage
class CategoryListItemModel {
  String id;
  String name;
  String description;
  String totalResults;

  CategoryListItemModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'];
    description = parsedJson['description'];
  }
}
