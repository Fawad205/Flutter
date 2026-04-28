import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  void playSound(int number ){
    final player = AudioPlayer();
    player.play(AssetSource('note$number.wav'));
  }

  Expanded xyloButton(Color color, int number){
    return Expanded(
      child:ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: (){
          playSound(number);
        },
        child: Text(''),
      ),
       );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          xyloButton(Colors.black, 1),
          xyloButton(Colors.blue, 2),
          xyloButton(Colors.blueGrey, 3),
          xyloButton(Colors.cyan, 4),
          xyloButton(Colors.greenAccent, 5),
          xyloButton(Colors.lime, 6),
          xyloButton(Colors.purpleAccent, 7),
        ],
      ),
    );
  }
}