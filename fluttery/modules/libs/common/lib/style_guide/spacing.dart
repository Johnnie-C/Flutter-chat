import 'package:flutter/material.dart';

extension Inset on EdgeInsets {

  // horizontal
  static const standardHorizontal = EdgeInsets.only(
    left: 16.0,
    right: 16.0,
  );

  static const largeHorizontal = EdgeInsets.only(
    left: 34.0,
    right: 34.0,
  );

  // vertical
  static const standardVertical = EdgeInsets.only(
    top: 16.0,
    bottom: 16.0,
  );

  static const smallVertical = EdgeInsets.only(
    top: 8.0,
    bottom: 8.0,
  );

}

extension Spacing on SizedBox {

  static const xxLarge = SizedBox(
    width: 40.0,
    height: 40.0,
  );

  static const large = SizedBox(
    width: 20.0,
    height: 20.0,
  );

  static const medium = SizedBox(
    width: 16.0,
    height: 16.0,
  );

  static const small = SizedBox(
    width: 8.0,
    height: 8.0,
  );

}
