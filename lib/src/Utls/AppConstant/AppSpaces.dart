import 'package:flutter/cupertino.dart';

class AppSpaces {
  static Padding spaces_height_5 = Padding(padding: EdgeInsets.only(top: 5));
  static Padding spaces_height_10 = Padding(padding: EdgeInsets.only(top: 10));
  static Padding spaces_height_15 = Padding(padding: EdgeInsets.only(top: 15));
  static Padding spaces_height_20 = Padding(padding: EdgeInsets.only(top: 20));
  static Padding spaces_height_25 = Padding(padding: EdgeInsets.only(top: 25));
  static Padding spaces_height_30 = Padding(padding: EdgeInsets.only(top: 30));
  static Padding spaces_height_35 = Padding(padding: EdgeInsets.only(top: 35));
  static Padding spaces_height_40 = Padding(padding: EdgeInsets.only(top: 40));

  static Padding spaces_width_5 = Padding(padding: EdgeInsets.only(left: 5));
  static Padding spaces_width_10 = Padding(padding: EdgeInsets.only(left: 10));
  static Padding spaces_width_15 = Padding(padding: EdgeInsets.only(left: 16));
  static Padding spaces_width_20 = Padding(padding: EdgeInsets.only(left: 20));

  static EdgeInsets spaces_all_5 = EdgeInsets.all(5);
  static EdgeInsets spaces_all_10 = EdgeInsets.all(10);
  static EdgeInsets spaces_all_15 =
      EdgeInsets.all(15); //Padding(padding: EdgeInsets.all(15));
  static EdgeInsets spaces_all_20 = EdgeInsets.all(20);

  static Padding spaces_width_25 = Padding(padding: EdgeInsets.only(left: 25));

  static EdgeInsets custom_spaces(
          {double left, double right, double bottom, double top}) =>
      EdgeInsets.only(
          left: left ?? 0,
          right: right ?? 0,
          top: top ?? 0,
          bottom: bottom ?? 0);

  static EdgeInsets custom_all_spaces(double space) => EdgeInsets.all(space);
}
