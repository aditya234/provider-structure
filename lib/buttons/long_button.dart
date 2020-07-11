import 'package:flutter/material.dart';
import 'package:providerstatemanage/sizeconfig.dart';
import 'package:providerstatemanage/text_styles.dart';

class CustomLongButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final double height;
  final Color color;
  final Widget icon;
  final double width;
  final TextStyle style;
  final bool hasRoundedCorners;
  final bool isVerticalDirection;
  final double horizontalPadding;

  CustomLongButton({
    @required this.title,
    @required this.onTap,
    @required this.height,
    this.color,
    this.icon,
    this.width,
    this.style,
    this.hasRoundedCorners = true,
    this.isVerticalDirection = false,
    this.horizontalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        constraints: BoxConstraints(
          minHeight: SizeConfig.getHeightRatio(height),
        ),
        width: width != null
            ? SizeConfig.getWidthRatio(width)
            : SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getWidthRatio(horizontalPadding),
        ),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: new BorderRadius.circular(
            SizeConfig.getHeightRatio(height) / (hasRoundedCorners ? 6 : 18),
          ),
          border: Border.all(
            color: (color ?? Theme.of(context).primaryColor).withAlpha(150),
          ),
        ),
        child: Flex(
          direction: isVerticalDirection ? Axis.vertical : Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon == null
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(
                      right: SizeConfig.getWidthRatio(4),
                    ),
                    child: icon,
                  ),
            Flexible(
              child: Text(
                title,
                style: style ?? CustomTextStyles.white16,
                overflow: TextOverflow.clip,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
