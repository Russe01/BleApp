import 'package:flutter/material.dart';
import 'package:mobile_computing_app/EsenseHandler.dart';
import 'package:esense_flutter/esense.dart';

class BleConnectionWidget extends StatefulWidget {
  final ValueChanged connectStatus;

  const BleConnectionWidget({super.key, required this.connectStatus});


  @override
  State<StatefulWidget> createState() => BleConnectionWidgetState();

}

class BleConnectionWidgetState extends State<BleConnectionWidget> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLE Connection"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 9, 0, 0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.cyanAccent,
              ),
              child: TextField(
                  decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                  labelText: "BLE device name",
                ),
                onSubmitted:(String value) => setState(() {
                  EsenseHandler().setDeviceName(value);
                  EsenseHandler().connect();
                }),
              ),
            )
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
            child: Text("When you are done typing the device name, press Enter to connect.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
            child: StreamBuilder(
              stream: EsenseHandler().eSenseManager?.connectionEvents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data!.type) {
                    case ConnectionType.connected:
                      widget.connectStatus("Connection: Connected");
                      return const Center(child: Text("Connection: Connected",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.blue))
                      );

                    case ConnectionType.unknown:
                      widget.connectStatus("Connection: Unknown");
                      return ElevatedButton(
                        onPressed: () => EsenseHandler().connect(),
                        child: const Text("Connection: Unknown\nPress to connect again"),
                      );

                    case ConnectionType.device_found:
                      widget.connectStatus("Connection: Device found");
                      return const Center(child: Text("Connection: Device found"));

                    case ConnectionType.disconnected:
                      widget.connectStatus("Connection: Disconnected");
                      return ElevatedButton(
                        onPressed: () => EsenseHandler().connect(),
                        child: const Text("Connection: Disconnected\nPress to connect again"),
                      );

                    case ConnectionType.device_not_found:
                      widget.connectStatus("Connection: Device \"${EsenseHandler().getDeviceName()}\" not found.");
                      return ElevatedButton(
                        onPressed: () => EsenseHandler().connect(),
                        child: Text("Connection: Device \"${EsenseHandler().getDeviceName()}\" not found\nPress to connect again"),
                      );
                  }
                } else {
                  return const Center(child: Text("No Connection Started",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic))
                  );
                }
              },
            )
          )
        ],
      ),
      backgroundColor: Colors.greenAccent,
    );
  }

}