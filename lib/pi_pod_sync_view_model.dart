import 'dart:async';

import 'package:bluetoothadapter/bluetoothadapter.dart';
import 'package:providerstatemanage/base_model.dart';

class PiPodSyncViewModel extends BaseModel {
  PiPodSyncViewModel._();

  static PiPodSyncViewModel _instance = PiPodSyncViewModel._();

  factory PiPodSyncViewModel() => _instance;

  //
  String SETUP_BLUETOOTH = "setup_bluetooth";
  String CONNECT_TO_DEVICE = "connect_to_device";

  //
  Bluetoothadapter flutterbluetoothadapter;

  List<BtDevice> devices = [];
  bool isBluetoothEnabled = false;
  bool isLoading = true;
  String connectionStatus = "NONE";
  String score = "0";
  StreamSubscription btConnectionStatusListener, scoreListener;

  Future setupBtConnection() async {
    try {
      setStatus(SETUP_BLUETOOTH, Status.Loading);
      if (connectionStatus == "NONE") {
        if (flutterbluetoothadapter == null) {
          flutterbluetoothadapter = Bluetoothadapter();
        }
        await flutterbluetoothadapter
            .initBlutoothConnection("20585adb-d260-445e-934b-032a2c8b2e14");

        startListening();
      }
      isBluetoothEnabled = await flutterbluetoothadapter.checkBluetooth();
      devices = await flutterbluetoothadapter.getDevices();
      if (!isBluetoothEnabled) {
        connectionStatus == "NONE";
      }
      setStatus(SETUP_BLUETOOTH, Status.Done);
    } catch (err) {
      setError(SETUP_BLUETOOTH,
          "Error occurred while setting up connection! Try again.");
    }
  }

  Future connectToDevice(BtDevice device) async {
    try {
      setStatus(CONNECT_TO_DEVICE, Status.Loading);
      connectionStatus = "Connecting ...";
      await flutterbluetoothadapter.startClient(devices.indexOf(device));
      setStatus(CONNECT_TO_DEVICE, Status.Done);
    } catch (err) {
      setError(CONNECT_TO_DEVICE,
          "Error occurred in connecting to device! Try again");
    }
  }

  startListening() {
    btConnectionStatusListener =
        flutterbluetoothadapter.connectionStatus().listen((dynamic status) {
      connectionStatus = status.toString();
      notifyListeners();
    });
  }

  startScoring() {
    scoreListener =
        flutterbluetoothadapter.receiveMessages().listen((dynamic status) {
      print("HERE EEE ${status}");
      score = status.toString();
      notifyListeners();
    });
  }

  stopScoring() {
    if (scoreListener != null) {
      scoreListener.cancel();
    }
  }

  startGame() {
    flutterbluetoothadapter.sendMessage("100", sendByteByByte: true);
    flutterbluetoothadapter.sendMessage(".", sendByteByByte: true);
  }

  startDemoGame() {
    flutterbluetoothadapter.sendMessage("500", sendByteByByte: true);
    flutterbluetoothadapter.sendMessage(".", sendByteByByte: true);
  }

  getScore() {
    flutterbluetoothadapter.sendMessage("200", sendByteByByte: true);
    flutterbluetoothadapter.sendMessage(".", sendByteByByte: true);
  }

  pauseGame() {
    flutterbluetoothadapter.sendMessage("300", sendByteByByte: true);
    flutterbluetoothadapter.sendMessage(".", sendByteByByte: true);
  }

  restartGame() {
    flutterbluetoothadapter.sendMessage("400", sendByteByByte: true);
    flutterbluetoothadapter.sendMessage(".", sendByteByByte: true);
  }

  shutdownPi() {
    flutterbluetoothadapter.sendMessage("0", sendByteByByte: true);
    flutterbluetoothadapter.sendMessage(".", sendByteByByte: true);
  }

  restartPi() {
    flutterbluetoothadapter.sendMessage("1", sendByteByByte: true);
    flutterbluetoothadapter.sendMessage(".", sendByteByByte: true);
  }

  forceTimerReset() {
    flutterbluetoothadapter.sendMessage("1000", sendByteByByte: true);
    flutterbluetoothadapter.sendMessage(".", sendByteByByte: true);
  }
}
