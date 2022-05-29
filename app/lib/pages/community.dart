import 'package:app/pages/write_comment.dart';
import 'package:flutter/material.dart';
import 'package:app/mock/post_2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/global_variables.dart';
import 'package:app/components/dialog.dart';

int _currentPostIndex = 0;

class EmojiButton extends StatefulWidget {
  final int emojiIndex;
  dynamic onPressed;
  EmojiButton({
    Key? key,
    required this.emojiIndex,
    required this.onPressed,
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
            "assets/icon/${emoji[widget.emojiIndex]}.svg",
            height: 30.0,
            width: 30.0,
          ),
          iconSize: 30,
          // animation
          onPressed: () => setState(() {
            String emojiName = emoji[widget.emojiIndex];
            if (mockPosts[_currentPostIndex]
                .emojiCounts
                .containsKey(emojiName)) {
              if (mockPosts[_currentPostIndex].emojiCounts[emojiName] != null) {
                mockPosts[_currentPostIndex].emojiCounts[emojiName] =
                    mockPosts[_currentPostIndex].emojiCounts[emojiName]! + 1;
              }
            } else {
              mockPosts[_currentPostIndex].emojiCounts[emojiName] = 1;
            }
          }),
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
  bool _showEmojiButtons = false, _isShowingEmojiButtons = false;

  void addEmoji(int index) {
    _showEmojiButtons = false;
    setState(() {
      Map<String, int> map = mockPosts[_currentPostIndex].emojiCounts;
      String emojiName = emoji[index];
      if (map.containsKey(emojiName)) {
        if (map[emojiName] != null) {
          map[emojiName] = map[emojiName]! + 1;
        }
      } else {
        map[emojiName] = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        children: <Widget>[
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
                    width: MediaQuery.of(context).size.width / 2 -
                        2 * postLRMargin,
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
                          _isShowingEmojiButtons = true;
                          _showEmojiButtons = true;
                        }
                      }),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2 -
                        2 * postLRMargin,
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
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WriteCommentPage(),
                          ),
                        );
                      },
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
          Visibility(
            visible: _isShowingEmojiButtons,
            child: Positioned(
              bottom: 140 + 2 * postLRMargin + 40 + 2 * postLRMargin,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: _showEmojiButtons ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                onEnd: () {
                  _isShowingEmojiButtons = false;
                },
                // The green box must be a child of the AnimatedOpacity widget.
                child: Container(
                  height: 40,
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    left: postLRMargin * 2,
                    right: postLRMargin * 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      EmojiButton(
                        emojiIndex: 0,
                        onPressed: () => addEmoji(0),
                      ),
                      EmojiButton(
                        emojiIndex: 1,
                        onPressed: () => addEmoji(1),
                      ),
                      EmojiButton(
                        emojiIndex: 2,
                        onPressed: () => addEmoji(2),
                      ),
                      EmojiButton(
                        emojiIndex: 3,
                        onPressed: () => addEmoji(3),
                      ),
                      EmojiButton(
                        emojiIndex: 4,
                        onPressed: () => addEmoji(4),
                      ),
                      EmojiButton(
                        emojiIndex: 5,
                        onPressed: () => addEmoji(5),
                      ),
                      EmojiButton(
                        emojiIndex: 6,
                        onPressed: () => addEmoji(6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
