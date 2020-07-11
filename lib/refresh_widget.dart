import 'package:flutter/material.dart';

class RefreshWidget extends StatelessWidget {
  final String error;
  final Function onRefresh;

  RefreshWidget({@required this.error, @required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            error,
            textAlign: TextAlign.center,
//            style: CustomTextStyles.black16,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: onRefresh,
          ),
        ],
      ),
    );
  }
}
