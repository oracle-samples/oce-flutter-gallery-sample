/*
 * Copyright (c) 2022, Oracle and/or its affiliates.
 * Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
 */

import 'package:flutter/material.dart';
import 'package:ocefluttergallerysample/utils/constants.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

int getNumColumns(BuildContext context) {
  int numColumns = 1;
  double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth <= 600) {
    numColumns = 1;
  } else if (screenWidth < 1200) {
    numColumns = 2;
  } else {
    numColumns = 3;
  }
  return numColumns;
}

int getNumColumnsForImageGrid(BuildContext context) {
  int numColumns = 1;
  double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth <= 600) {
    numColumns = 2;
  } else if (screenWidth < 1200) {
    numColumns = 3;
  } else {
    numColumns = 4;
  }
  return numColumns;
}

double getAspectRatio(BuildContext context) {
  var size = MediaQuery.of(context).size;

  final double itemHeight = 420 ;//approx height of the card grid
  int numColumns = getNumColumns(context);
  final double itemWidth = size.width ~/ numColumns - (numColumns+1)*kGridSpacing;
  double aspectRatio = itemWidth / itemHeight;
  return aspectRatio;
}