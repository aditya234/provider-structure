import 'package:flutter/material.dart';
import 'package:providerstatemanage/sizeconfig.dart';
import 'package:providerstatemanage/theme.dart';

Widget numberButtonWithCircle(int value, Function onTap) {
  return InkWell(
    onTap: () {
      onTap(value);
    },
    child: Container(
      height: SizeConfig.getHeightRatio(43),
      width: SizeConfig.getWidthRatio(43),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Themes.primaryColor, width: SizeConfig.getWidthRatio(1))),
      child: Center(
          child: Text("$value",
              style: TextStyle(fontSize: SizeConfig.getFontRatio(30)))),
    ),
  );
}

Widget numberButton(int value, Function onTap) {
  return InkWell(
    onTap: () {
      onTap(value);
    },
    child: Container(
      height: SizeConfig.getHeightRatio(61),
      width: SizeConfig.getWidthRatio(57),
      child: Center(
          child: Text("$value",
              style: TextStyle(fontSize: SizeConfig.getFontRatio(30)))),
    ),
  );
}
