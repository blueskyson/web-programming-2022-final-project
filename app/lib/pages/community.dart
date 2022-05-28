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
                Positioned(
                  // draw a red marble
                  top: 33.0,
                  right: 33.0,
                  child: Text("${mockPosts.length - _currentPostIndex}"),
                )
              ]),
            ),

            /* Post body */
            mockPosts[_currentPostIndex],

            /* Add comment */
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              direction: Axis.horizontal,
              children: [
                Container(
                  height: 40,
                  width:
                      MediaQuery.of(context).size.width / 2 - 2 * postLRMargin,
                  margin: const EdgeInsets.all(postLRMargin),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.only(left: 50, right: 50),
                    ),
                    child: const Text(
                      "新增表情",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 40,
                  width:
                      MediaQuery.of(context).size.width / 2 - 2 * postLRMargin,
                  margin: const EdgeInsets.all(postLRMargin),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.only(left: 50, right: 50),
                    ),
                    child: const Text(
                      "新增留言",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
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
