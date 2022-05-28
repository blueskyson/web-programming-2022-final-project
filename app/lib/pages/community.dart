import 'package:flutter/material.dart';
import 'package:app/mock/post_2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/global_variables.dart';
import 'package:app/components/dialog.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final int _currentPostIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Stack(children: <Widget>[
                Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  child: IconButton(
                    icon: SvgPicture.asset("assets/icon/cards.svg"),
                    iconSize: cardsIconSize,
                    // animation
                    onPressed: () {},
                  ),
                ),
                /* For displaying card number */
                // Positioned(
                //   // draw a red marble
                //   top: 35.0,
                //   right: 35.0,
                //   child: Icon(Icons.brightness_1,
                //       size: 20.0, color: Colors.black),
                // )
              ]),
            ),

            /* Post body */
            mockPosts[_currentPostIndex],

            /* Add comment */
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: postLRMargin,
                    right: postLRMargin,
                    top: postLRMargin,
                  ),
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: const Text(
                    "新增表情",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: postLRMargin,
                    right: postLRMargin,
                    top: postLRMargin,
                  ),
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: const Text(
                    "新增留言",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        /* Dialog */
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AvatarDialog(
            message:
                "${mockPosts[_currentPostIndex].author}說: ${mockPosts[_currentPostIndex].title}",
          ),
        ),
      ],
    );
  }
}
