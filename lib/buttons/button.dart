import 'package:flutter/material.dart';
import 'package:providerstatemanage/sizeconfig.dart';

// A customised rounded button
class RoundedButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  final double height;
  final double width;
  final double bottomMargin;
  final double borderWidth;
  final Color buttonColor;
  final TextStyle textStyle;
  final Widget widget;

  RoundedButton(
      {this.buttonName,
      this.onTap,
      this.height,
      this.bottomMargin,
      this.borderWidth,
      this.textStyle,
      this.width,
      this.buttonColor,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return (InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        constraints: BoxConstraints(minWidth: SizeConfig.getWidthRatio(60)),
        margin: EdgeInsets.only(bottom: bottomMargin),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: widget ??
            Text(buttonName, style: textStyle, textAlign: TextAlign.center),
      ),
    ));
  }
}
