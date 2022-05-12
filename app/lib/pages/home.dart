//import 'package:app/components/navel.dart';
import 'package:flutter/material.dart';
//import 'package:circular_menu/circular_menu.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:app/mock/post_2.dart';

//import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //static const Widget _image = Image(image: AssetImage('assets/pic/hiyori.png'));
  //static const Navel _navel = Navel();
  static final InAppWebView _wk = InAppWebView(
    initialUrlRequest: URLRequest(
        url: Uri.parse('http://localhost:9188/assets/local/index.html')),
    initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
      disableHorizontalScroll: true,
      disableVerticalScroll: true,
      supportZoom: false,
    )),
  );
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
    return GestureDetector(
      child: Stack(
        children: [
          _wk,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 140,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "早安，歡迎回來，今天有 ${mockPosts.length} 個朋友更新投資情況，一起來看看吧！",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      onLongPress: () => setState(
        () {
          debugPrint(toggle.toString());
          toggle = !toggle;
        },
      ),

      //_circularMenu,
      //Visibility(child:_circularMenu,visible: toggle,),
    );
  }
}
