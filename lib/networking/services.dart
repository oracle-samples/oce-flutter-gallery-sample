/*
 * Copyright (c) 2022, Oracle and/or its affiliates.
 * Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
 */

import 'content.dart';

//Helper class for making all the API calls needed for the app
class Services {
  // Fetch the taxonomies for the channel set in the delivery client.
  // @returns {*} - array of taxonomy ids for the channel
  Future<List<String>> fetchTaxonomies() async {
    final Content content = Content();
    try {
      dynamic data = await content.getTaxonomies();
      dynamic taxonomies = data['items'];
      List<String> idArray = [];
      for (var taxonomy in taxonomies) {
        idArray.add(taxonomy['id']);
      }
      return idArray;
    } catch (exception) {
      rethrow;
    }
  }

  // Fetch the categories for the specified taxonomyId.
  // @param {string} taxonomyId - the id of the taxonomy for which the categories are desired
  // @returns {*} - categories for the specified taxonomyId
  Future<List<dynamic>> fetchCategories(taxonomyId) async {
    final Content content = Content();
    dynamic data = await content.queryTaxonomyCategories({
      'id': '$taxonomyId',
    });
    return data['items'];
  }

  // Fetch the items that belong to the category whose id is specified.
  // @param {string} categoryId - the id of the category for which items are to be fetched
  // @param {boolean} limit - whether a limit of 4 needs to be applieds
  // @returns {*} - items that belong to the category
  Future<dynamic> fetchItemsForCategory(String categoryId, bool limit) async {
    final Content content = Content();
    dynamic data = await content.queryItems({
      'q': '(taxonomies.categories.nodes.id eq "$categoryId")',
      'fields': 'all',
      'expand': 'all',
      'limit': limit ? '4' : '100',
      'totalResults': 'true',
    });
    return data;
  }

  // Retrieve the thumbnail URL for the item specified.
  // @param {String} identifier - the Id of the item whose thumbnail URL is required
  // @returns {String} - the thumbnail URL
  Future<String> retrieveThumbnailURL(identifier) async {
    final Content content = Content();
    dynamic data = await content.getItem({
      'id': identifier,
      'fields': 'all',
      'expand': 'all',
    });
    String url = data['fields']['renditions'][1]['formats'][0]['links'][0]['href'];
    return url;
  }

  // Get all the images needed for the app
  String getMediumRenditionUrl(thumbnailId) {
    final Content content = Content();
    try {
      return content.getMediumRenditionUrl(<String, String>{
        'id': thumbnailId,
      });
    } catch (exception) {
      rethrow;
    }
  }

  // Get all the images needed for the app
  String getRenditionUrl(imageId) {
    final Content content = Content();
    try {
      return content.getRenditionURL(<String, String>{
        'id': imageId,
      });
    } catch (exception) {
      rethrow;
    }
  }
}
