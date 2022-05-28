import 'package:flutter/material.dart';
import 'package:app/mock/post_2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/global_variables.dart';
import 'package:app/components/dialog.dart';

class EmojiButton extends StatefulWidget {
  final String name;
  const EmojiButton({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  _EmojiButtonState createState() => _EmojiButtonState();
}

class _EmojiButtonState extends State<EmojiButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: 36,
        margin: const EdgeInsets.all(0),
        child: IconButton(
          icon: SvgPicture.asset(
            "assets/icon/${widget.name}.svg",
            height: 30.0,
            width: 30.0,
          ),
          iconSize: 30,
          // animation
          onPressed: () => setState(() {}),
        ),
      ),
    );
  }
}

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final int _currentPostIndex = 0;
  bool _showEmojiButtons = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = <Widget>[
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
                width: MediaQuery.of(context).size.width / 2 - 2 * postLRMargin,
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
                  child: Text(
                    "新增表情",
                    style: TextStyle(
                      color: _showEmojiButtons ? Colors.blue : Colors.white,
                    ),
                  ),
                  onPressed: () => setState(() {
                    if (_showEmojiButtons) {
                      _showEmojiButtons = false;
                    } else {
                      _showEmojiButtons = true;
                    }
                  }),
                ),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 2 - 2 * postLRMargin,
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
    ];

    /* Add emoji */
    if (_showEmojiButtons) {
      _widgets.add(
        Positioned(
          bottom: 140 + 2 * postLRMargin + 40 + 2 * postLRMargin,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.only(
              left: postLRMargin * 2,
              right: postLRMargin * 2,
            ),
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EmojiButton(name: emoji[0]),
                EmojiButton(name: emoji[1]),
                EmojiButton(name: emoji[2]),
                EmojiButton(name: emoji[3]),
                EmojiButton(name: emoji[4]),
                EmojiButton(name: emoji[5]),
                EmojiButton(name: emoji[6]),
              ],
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      // Make empty spaces clickable
      behavior: HitTestBehavior.translucent,

      // Lose the current Focus after clicking
      onTap: () {
        setState(() {
          _showEmojiButtons = false;
        });
        FocusScope.of(context).requestFocus(FocusNode());
      },

      child: Stack(
        children: _widgets,
      ),
    );
  }
}
