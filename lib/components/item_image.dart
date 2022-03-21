/*
 * Copyright (c) 2022, Oracle and/or its affiliates.
 * Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ocefluttergallerysample/networking/services.dart';
import 'package:ocefluttergallerysample/utils/constants.dart';

class ItemImage extends StatefulWidget {
  // Constructor that accepts the item id. Default the thumbnail param to true.
  ItemImage(
      {@required this.itemId, this.height, this.fit, this.thumbnail = true});

  final String itemId;
  final double height;
  final BoxFit fit;
  final bool thumbnail;

  @override
  _ItemImageState createState() => _ItemImageState();
}

class _ItemImageState extends State<ItemImage> {
  String imageUrl;
  String exception;

  @override
  void initState() {
    super.initState();
    if (mounted) fetchData();
  }

  // Construct the medium/native image urls
  fetchData() {
    final Services services = Services();
    //does not require an async call
    imageUrl = widget.thumbnail
        ? services.getMediumRenditionUrl(widget.itemId)
        : services.getRenditionUrl(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => Image(
        image: AssetImage(kPlaceholderImage),
        fit: BoxFit.contain,
        height: widget.height,
      ),
      imageUrl: imageUrl,
      height: widget.height,
      fit: widget.fit == null ? BoxFit.cover : widget.fit,
    );
  }
}
