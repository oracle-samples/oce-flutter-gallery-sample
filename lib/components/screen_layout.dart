/*
 * Copyright (c) 2022, Oracle and/or its affiliates.
 * Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
 */

import 'package:flutter/material.dart';
import 'package:ocefluttergallerysample/utils/constants.dart';

class ScreenLayout extends StatelessWidget {
  ScreenLayout({@required this.exception, this.loading, @required this.body});

  final String exception;
  final bool loading;
  final Widget body;

  Widget getContentWidget(BuildContext context) {
    return (exception != null)
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                exception,
                style: TextStyle(
                  fontSize: 20,
                  color: kActionbarColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : loading
            ?
            // By default, show a loading spinner.
            Center(child: CircularProgressIndicator())
            : body;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: getContentWidget(context),
    );
  }
}
