import 'package:flutter/material.dart';
class Navel extends StatefulWidget{
  const Navel({Key? key}) : super(key: key);
  @override
  State<Navel> createState() => _NavelState();
}

class _NavelState extends State<Navel>{
  @override
  Widget build(BuildContext context){
    return Stack(children: [
      Positioned(child: TextButton(child: const Text('d'),onPressed: () => {debugPrint('P1')},))
    ],);
  }
}