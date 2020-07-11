import 'package:flutter/material.dart';
import 'package:providerstatemanage/sizeconfig.dart';

class HeightBox extends StatelessWidget {
  final double height;

  const HeightBox(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.getHeightRatio(height),
    );
  }
}

class WidthBox extends StatelessWidget {
  final double width;

  const WidthBox(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.getWidthRatio(width),
    );
  }
}
