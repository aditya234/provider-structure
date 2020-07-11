import 'package:bluetoothadapter/bluetoothadapter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstatemanage/error_dialog.dart';
import 'package:providerstatemanage/navigator_keys.dart';
import 'package:providerstatemanage/pi_pod_sync_view_model.dart';
import 'package:providerstatemanage/provider_callback.dart';
import 'package:providerstatemanage/status_handeller.dart';
import 'package:providerstatemanage/text_styles.dart';

import 'sizeconfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PiPodSyncViewModel>(
          create: (context) => PiPodSyncViewModel(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: NavigationKeys.globalNavigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PiPodSyncViewModel _piPodSyncViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_piPodSyncViewModel == null) {
      _piPodSyncViewModel =
          Provider.of<PiPodSyncViewModel>(context, listen: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StatusHandeller<PiPodSyncViewModel>(
          statusString: "setup_bluetooth",
          showErrorDialogue: true,
          successBuilder: (_provider) {
            if (!_provider.isBluetoothEnabled) {
              ErrorDialog().show(
                "Please turn on the Bluetooth",
                context: context,
                onButtonPressed: () {
                  _provider.setupBtConnection();
                },
                buttonText: "Reload",
                includeCancel: false,
              );
            }
            return _provider.devices.isEmpty
                ? Center(
                    child: Text(
                      "No Paired devices.",
                      style: CustomTextStyles.black18,
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Status: ${_piPodSyncViewModel.connectionStatus.toUpperCase()}",
                          style: CustomTextStyles.grey14,
                        ),
                        trailing: Container(
                          width: 12.toWidth,
                          height: 12.toHeight,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _piPodSyncViewModel.connectionStatus ==
                                    "LISTENING"
                                ? Colors.blueGrey
                                : _piPodSyncViewModel.connectionStatus ==
                                        "Connecting ..."
                                    ? Colors.orange
                                    : _piPodSyncViewModel.connectionStatus ==
                                            "Connected"
                                        ? Colors.green
                                        : Colors.redAccent,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _provider.devices.length,
                        itemBuilder: (context, index) {
                          return _createListItem(_provider.devices[index]);
                        },
                      )
                    ],
                  );
          },
          load: (provider) async {
            await provider.setupBtConnection();
          }),
    );
  }

  Widget _createListItem(BtDevice device) {
    return InkWell(
      key: UniqueKey(),
      onTap: () async {
        providerCallback<PiPodSyncViewModel>(
          context,
          task: (provider) async {
            provider.connectToDevice(device);
          },
          taskName: (provider) => provider.CONNECT_TO_DEVICE,
          onSuccess: (provider) async {
            //
          },
          onError: (err) {
            //
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(4.toWidth),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: ListTile(
          title: Text(
            device.name.toString(),
            style: CustomTextStyles.black18,
          ),
        ),
      ),
    );
  }
}
