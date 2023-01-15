import 'package:flutter/material.dart';
import 'package:mobile_computing_app/EsenseHandler.dart';
import 'dart:io';

import 'package:vector_math/vector_math.dart' as convert;


class TiltWidget extends StatefulWidget {
  const TiltWidget({super.key});

  @override
  State<StatefulWidget> createState() => TiltWidgetState();

}


class TiltWidgetState extends State<TiltWidget> {
  double rotateAngle = 0;

  @override
  void initState() {
    rotateAngle = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tilt"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.cyan,
                  ),
                  child: const Text("Tilt your head to the left/right and the picture will rotate 10 degree to the left/right. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),)
              ),
            ),
            StreamBuilder(
              stream: EsenseHandler().sensorEvent,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.gyro![1] >= 4000) {
                    rotateAngle -= 10;
                  } else if (snapshot.data!.gyro![1] <= -4000) {
                    rotateAngle += 10;
                  }
                  return Padding(
                      padding: const EdgeInsets.all(70),
                      child: Transform.rotate(
                        angle: convert.radians(rotateAngle),
                        child: Image.asset("assets/images/flutter-logo.jpg")
                      ),
                  );
                } else {
                  return Padding(
                      padding: const EdgeInsets.all(70),
                      child: Transform.rotate(
                        angle: convert.radians(rotateAngle),
                        child: Image.asset("assets/images/flutter-logo.jpg")
                      )
                  );
                }
              },
            )
          ],
        )
      ),
      backgroundColor: Colors.greenAccent,

    );
  }

}


