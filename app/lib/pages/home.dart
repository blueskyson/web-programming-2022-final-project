//import 'package:app/components/navel.dart';
import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';
class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  static const Widget _image = Image(image: AssetImage('assets/pic/hiyori.png'));
  //static const Navel _navel = Navel();
  static bool toggle = false;
  final _circularMenu = CircularMenu(items: [
    CircularMenuItem(icon: Icons.home, onTap: () {
      // callback
    }),
    CircularMenuItem(icon: Icons.search, onTap: () {
      //callback
    }),
    CircularMenuItem(icon: Icons.settings, onTap: () {
      //callback
    }),
    CircularMenuItem(icon: Icons.star, onTap: () {
      //callback
    }),
    CircularMenuItem(icon: Icons.pages, onTap: () {
      //callback
    }),
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 800.0,
        width: 500.0,
        padding: const EdgeInsets.only(top: 150,bottom:0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
        ),
        child: Stack(
          children:[
            GestureDetector(child:const Center(child: _image,),onLongPress: ()=>setState(() {
                debugPrint(toggle.toString());
                toggle=!toggle;
            }),
            ),
            //_circularMenu,
            Visibility(child:_circularMenu,visible: toggle,),
          ],
        ),
      ),
    );
  }
}
