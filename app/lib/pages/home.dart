//import 'package:app/components/navel.dart';
import 'package:flutter/material.dart';
//import 'package:circular_menu/circular_menu.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  //static const Widget _image = Image(image: AssetImage('assets/pic/hiyori.png'));
  //static const Navel _navel = Navel();
  static final InAppWebView _wk = InAppWebView(initialUrlRequest: URLRequest(url: Uri.parse('http://localhost:9188/assets/local/index.html')),);
  static bool toggle = false;
  /*final _circularMenu = CircularMenu(items: [
    CircularMenuItem(icon: IconData(Icons.search.codePoint,fontFamily: Icons.search.fontFamily), onTap: () {
      // callback
    }),
    CircularMenuItem(icon: IconData(MdiIcons.fromString('chat-processing')!.codePoint,fontFamily: MdiIcons.fromString('chat-processing')!.fontFamily), onTap: () {
      //callback
    }),
    CircularMenuItem(icon: IconData(MdiIcons.fromString('home')!.codePoint,fontFamily: MdiIcons.fromString('home')!.fontFamily), onTap: () {
      //callback
    }),
    CircularMenuItem(icon: IconData(MdiIcons.fromString('finance')!.codePoint,fontFamily: MdiIcons.fromString('finance')!.fontFamily), onTap: () {
      //callback
    }),
    CircularMenuItem(icon: IconData(MdiIcons.fromString('account')!.codePoint,fontFamily: MdiIcons.fromString('account')!.fontFamily), onTap: () {
      //callback
    }),
  ]);*/
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
            GestureDetector(child: Center(child: _wk,),onLongPress: ()=>setState(() {
                debugPrint(toggle.toString());
                toggle=!toggle;
            }),
            ),
            //_circularMenu,
            //Visibility(child:_circularMenu,visible: toggle,),
          ],
        ),
      ),
    );
  }
}
