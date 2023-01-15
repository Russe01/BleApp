import 'package:flutter/material.dart';

import 'BLEConnection.dart';
import 'StartView.dart';
import 'Tilt.dart';

class BleApp extends StatefulWidget {
  const BleApp({super.key});

  @override
  State<StatefulWidget> createState() => _BleAppState();

}

class _BleAppState extends State<BleApp> {


  String bleStatus = "Connection not started";
  int? windowIndex;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Navigator(
          pages: [
            MaterialPage(child: StartView(
              selectWindowIndex: (index) {
                setState(() {
                  windowIndex = index;
                });
              },
              getBleStatus: () {
                return bleStatus;
              },
            )),
            if (windowIndex == 0)
              MaterialPage(child: BleConnectionWidget(
                  connectStatus: (status) {
                    bleStatus = status;
                  }
              )),
            if (windowIndex == 1)
              MaterialPage(
                  child: TiltWidget()
              )

          ],
          onPopPage: (route, result) {
            setState(() => {
              windowIndex = null
            });
            return route.didPop(result);
          },
        )
    );
  }

}