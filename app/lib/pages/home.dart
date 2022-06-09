import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:app/mock/post_2.dart';
import 'package:app/components/dialog.dart';
import 'package:vector_math/vector_math.dart' show radians;

//import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        AutomaticKeepAliveClientMixin<HomePage>,
        SingleTickerProviderStateMixin {
  // radial menu
  bool _isShowingRadialMenu = false;
  double _radialMenuLeft = 0.0;
  double _radialMenuTop = 0.0;
  double _panX = 0.0;
  double _panY = 0.0;
  late AnimationController _controller;
  late Animation<double> _translation;

  // webview
  static final InAppWebView _wk = InAppWebView(
    initialUrlRequest: URLRequest(
      url: Uri.parse('http://localhost:9188/assets/local/index.html'),
    ),
    initialOptions: InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        disableHorizontalScroll: true,
        disableVerticalScroll: true,
        supportZoom: false,
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double radialMenuSize = MediaQuery.of(context).size.width * 0.4;
    final double degree = atan2(_panY, _panX) * (180 / pi);

    // opacities of 4 buttons
    var opacities = <int, double>{
      1: 1,
      2: 1,
      3: 1,
      4: 1,
    };

    if (degree > 45) {
      if (degree > 135) {
        // left button [135, 180]
        opacities[4] = 0.5;
      } else {
        // top button [45, 135]
        opacities[1] = 0.5;
      }
    } else {
      if (degree > -45) {
        // right button [-45, 45]
        opacities[2] = 0.5;
      } else if (degree > -135) {
        // bottom button [-135, -45]
        opacities[3] = 0.5;
      } else {
        // left button [-180, -135]
        opacities[4] = 0.5;
      }
    }

    return GestureDetector(
      child: Stack(
        children: [
          _wk,

          /* dialog */
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TextDialog(
              message: "早安，歡迎回來，今天有 ${mockPosts.length} 個朋友更新投資情況，一起來看看吧！",
            ),
          ),

          /* Radial Menu */
          Positioned(
            top: _radialMenuTop - (radialMenuSize / 2),
            left: _radialMenuLeft - (radialMenuSize / 2),
            child: Visibility(
              visible: _isShowingRadialMenu,
              child: SizedBox(
                width: radialMenuSize,
                height: radialMenuSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    _buildButton(
                      angle: 270,
                      diameter: radialMenuSize,
                      buttonPath: "assets/radial/radial_menu_1.png",
                      iconPath: "assets/radial/radial_item_1.png",
                      opacity: opacities[1]!,
                    ),
                    _buildButton(
                      angle: 0,
                      diameter: radialMenuSize,
                      buttonPath: "assets/radial/radial_menu_2.png",
                      iconPath: "assets/radial/radial_item_2.png",
                      opacity: opacities[2]!,
                    ),
                    _buildButton(
                      angle: 90,
                      diameter: radialMenuSize,
                      buttonPath: "assets/radial/radial_menu_3.png",
                      iconPath: "assets/radial/radial_item_3.png",
                      opacity: opacities[3]!,
                    ),
                    _buildButton(
                      angle: 180,
                      diameter: radialMenuSize,
                      buttonPath: "assets/radial/radial_menu_4.png",
                      iconPath: "assets/radial/radial_item_4.png",
                      opacity: opacities[4]!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      /* swipe events */
      onPanDown: (e) {
        _radialMenuLeft = e.localPosition.dx;
        _radialMenuTop = e.localPosition.dy;
        setState(() {
          _isShowingRadialMenu = true;
        });
      },
      onPanStart: (e) {},
      onPanUpdate: (e) {
        setState(() {
          _panX = e.localPosition.dx - _radialMenuLeft;
          _panY = _radialMenuTop - e.localPosition.dy;
        });
      },
      onPanEnd: (e) {
        debugPrint(e.toString());
        setState(() {
          _isShowingRadialMenu = false;
        });
      },
      onPanCancel: () {
        setState(() {
          _isShowingRadialMenu = false;
        });
      },
    );
  }

  Widget _buildButton({
    required double angle,
    required double diameter,
    required String buttonPath,
    required String iconPath,
    required double opacity,
  }) {
    final double iconSize = diameter * (35 / 200);
    final double radius = diameter / 2;
    final double x = radius * 0.6 * cos(radians(angle));
    final double y = radius * 0.6 * sin(radians(angle));
    return Stack(
      children: [
        Opacity(
          opacity: opacity,
          child: Image(
            image: AssetImage(buttonPath),
            width: diameter,
            height: diameter,
          ),
        ),
        Positioned(
          top: radius - (iconSize / 2) + y,
          left: radius - (iconSize / 2) + x,
          child: Image(
            image: AssetImage(iconPath),
            width: iconSize,
            height: iconSize,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
