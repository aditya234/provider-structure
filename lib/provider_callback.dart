import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstatemanage/base_model.dart';
import 'package:providerstatemanage/error_dialog.dart';
import 'package:providerstatemanage/loading_dialog.dart';

void providerCallback<T extends BaseModel>(BuildContext context,
    {@required final Future Function(T) task,
    @required final String Function(T) taskName,
    @required Function(T) onSuccess,
    Function onError}) async {
  final T _provider = Provider.of<T>(context, listen: false);
  String _taskName = taskName(_provider);
  print("CAME HERE");
  LoadingDialog().show();
  await Future.microtask(() => task(_provider));
  LoadingDialog().hide();
  print(_provider.status[_taskName]);
  if (_provider.status[_taskName] == Status.Error) {
    print("has error");
    ErrorDialog().show(_provider.error[_taskName], context: context);
    if (onError != null) onError(_provider);
    _provider.reset(_taskName);
  } else if (_provider.status[_taskName] == Status.Done) {
    onSuccess(_provider);
  }
}
