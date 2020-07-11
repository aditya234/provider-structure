import 'package:flutter/material.dart';
import 'package:providerstatemanage/sizeconfig.dart';
import 'package:providerstatemanage/text_styles.dart';
import 'package:providerstatemanage/theme.dart';

Widget bottomButton(
    {@required BuildContext context,
    @required String buttomName,
    @required Function onPressed,
    double height = 72}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      color: Themes.primaryColor,
      height: SizeConfig.getHeightRatio(height),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          "$buttomName",
          style: CustomTextStyles.white18,
        ),
      ),
    ),
  );
}
