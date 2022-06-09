import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:app/mock/post_2.dart';
import 'package:app/components/dialog.dart';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  static bool _toggle = false;

  // radial menu
  late AnimationController _controller;
  late List<Widget> _menu;
  late Animation<double> _rotation;
  late Animation<double> _translation;

  // webview
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
    final double radialMenuWidth = MediaQuery.of(context).size.width * 0.4;
    final double radialMenuHeight = MediaQuery.of(context).size.height - 230;

    _rotation = Tween<double>(
      begin: 0.0,
      end: 360.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.7,
          curve: Curves.decelerate,
        ),
      ),
    );

    _translation = Tween<double>(
      begin: 0.0,
      end: MediaQuery.of(context).size.width * 0.4,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

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
            top: 0,
            left: (MediaQuery.of(context).size.width - radialMenuWidth) / 2,
            child: SizedBox(
              width: radialMenuWidth,
              height: radialMenuHeight,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, widget) {
                  return Transform.rotate(
                    angle: radians(_rotation.value),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        _buildButton(
                          45,
                          color: Colors.red,
                          icon: FontAwesomeIcons.thumbtack,
                        ),
                        _buildButton(
                          135,
                          color: Colors.green,
                          icon: FontAwesomeIcons.sprayCan,
                        ),
                        _buildButton(
                          225,
                          color: Colors.orange,
                          icon: FontAwesomeIcons.fire,
                        ),
                        _buildButton(
                          315,
                          color: Colors.blue,
                          icon: FontAwesomeIcons.kiwiBird,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      onTapDown: (details) => setState(
        () {
          double leftborder =
              (MediaQuery.of(context).size.width - radialMenuWidth) / 2;
          double rightborder = leftborder + radialMenuWidth;
          double topborder = 0;
          double bottomborder = radialMenuHeight;

          if (details.localPosition.dx > leftborder &&
              details.localPosition.dx < rightborder &&
              details.localPosition.dy > topborder &&
              details.localPosition.dy < bottomborder) {
            _toggle = !_toggle;
          } else {
            _toggle = false;
          }

          if (_toggle) {
            _openMenu();
          } else {
            _closeMenu();
          }

          debugPrint(_toggle.toString());
        },
      ),
      onPanDown: (e) {
        debugPrint(e.toString());
      },
      onPanStart: (e) {
        debugPrint(e.toString());
      },
      onPanUpdate: (e) {
        debugPrint(e.localPosition.toString());
      },
      onPanEnd: (e) {
        debugPrint(e.toString());
      },
      onPanCancel: () {
        debugPrint("Pan cancel");
      },
    );
  }

  _openMenu() {
    _controller.forward();
  }

  _closeMenu() {
    _controller.reverse();
  }

  Widget _buildButton(
    double angle, {
    required Color color,
    required IconData icon,
  }) {
    final double rad = radians(angle);

    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (_translation.value) * cos(rad),
          (_translation.value) * sin(rad),
        ),
      child: FloatingActionButton(
        child: Icon(icon),
        backgroundColor: color,
        onPressed: _closeMenu,
        elevation: 0,
      ),
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
