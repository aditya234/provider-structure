import 'package:flutter/material.dart';
import 'package:providerstatemanage/buttons/long_button.dart';
import 'package:providerstatemanage/custom_popup_route.dart';
import 'package:providerstatemanage/navigator_keys.dart';
import 'package:providerstatemanage/sized_boxes.dart';
import 'package:providerstatemanage/text_styles.dart';
import 'package:providerstatemanage/theme.dart';

import 'sizeconfig.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String text;
  final String buttonText;
  final Function onButtonPress;
  final bool includeCancel;

  ErrorDialogWidget({
    @required this.text,
    this.buttonText,
    this.onButtonPress,
    this.includeCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
//          height: 160.toHeight,
          decoration: BoxDecoration(
            color: Themes.greyDisabledFields,
            borderRadius: BorderRadius.circular(
              20.toFont,
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.toWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              HeightBox(20),
              Text(
                "Error",
                style: CustomTextStyles.black20
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              HeightBox(10),
              Text(
                text,
                style: CustomTextStyles.black14,
                textAlign: TextAlign.center,
              ),
              HeightBox(10),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomLongButton(
                      color: Theme.of(context).primaryColor,
                      title: buttonText ?? "OK",
                      onTap: () {
                        Navigator.of(context).pop();
                        if (onButtonPress != null) onButtonPress();
                      },
                      style: CustomTextStyles.white16,
                      icon: null,
                      height: 50,
                      width: 120,
                    ),
                    if (includeCancel) ...[
                      CustomLongButton(
                        color: Theme.of(context).primaryColor,
                        title: "Cancel",
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        style: CustomTextStyles.white16,
                        icon: null,
                        height: 50,
                        width: 120,
                      )
                    ],
                  ]),
              HeightBox(20)
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorDialog {
  ErrorDialog._();

  static ErrorDialog _instance = ErrorDialog._();

  factory ErrorDialog() => _instance;
  bool _showing = false;

  show(String text,
      {String buttonText,
      Function onButtonPressed,
      @required BuildContext context,
      bool includeCancel = false}) {
    if (!_showing) {
      _showing = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        NavigationKeys.globalNavigatorKey.currentState
            .push(
          CustomPopupRoutes(
              pageBuilder: (_, __, ___) => ErrorDialogWidget(
                    text: text,
                    buttonText: (buttonText == null) ? "OK" : buttonText,
                    onButtonPress: onButtonPressed,
                    includeCancel: includeCancel,
                  ),
              barrierDismissible: true),
        )
            .then((_) {
          print("hidden error");
          _showing = false;
        });
      });
    }
  }

  hide() {
    if (_showing) NavigationKeys.globalNavigatorKey.currentState.pop();
  }
}
