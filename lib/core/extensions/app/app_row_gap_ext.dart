import 'package:flutter/material.dart';

extension AppRowGapExt on Row {
  Row withGap(double gap) {
    final widgets = children;
    if (widgets.isEmpty) return this;

    final spaced = <Widget>[];
    for (var i = 0; i < widgets.length; i++) {
      spaced.add(widgets[i]);
      if (i != widgets.length - 1) {
        spaced.add(SizedBox(width: gap));
      }
    }

    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: spaced,
    );
  }
}