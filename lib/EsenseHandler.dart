


import 'package:esense_flutter/esense.dart';

class EsenseHandler {
  ESenseManager? eSenseManager;
  String? deviceName;
  static final EsenseHandler _instance = EsenseHandler._private();

  EsenseHandler._private();

  factory EsenseHandler() {
    return _instance;
  }

  void setDeviceName(String deviceName) {
    this.deviceName = deviceName;
    eSenseManager = ESenseManager(deviceName);
  }

  String? getDeviceName() {
    return deviceName;
  }


  Future<void> connect() async {
    if (eSenseManager == null) {
      return;
    }
    await eSenseManager!.disconnect();
    await eSenseManager!.connect();
  }

  Stream<SensorEvent>? get sensorEvent {
    if (eSenseManager == null) {
      return null;
    } else {
      if (eSenseManager!.connected) {
        return eSenseManager!.sensorEvents;
      } else {
        return null;
      }
    }
  }
}