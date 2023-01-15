import 'package:flutter/material.dart';

class StartView extends StatelessWidget {

  final ValueChanged selectWindowIndex;
  final ValueGetter getBleStatus;

  StartView({super.key, required this.selectWindowIndex, required this.getBleStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
        ),
        body: GridView.count(
          crossAxisCount: 1,
          padding: EdgeInsets.all(20),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            GestureDetector(
              onTap: () => selectWindowIndex(0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.greenAccent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.bluetooth, color: Colors.indigo),
                    Text(getBleStatus())
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => selectWindowIndex(1),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.greenAccent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.loop, color: Colors.indigo),
                    Text("Tilt")
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}