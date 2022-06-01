import 'package:app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmojiButton extends StatefulWidget {
  final int emojiIndex;
  final dynamic onPressed;

  const EmojiButton({
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
        margin: const EdgeInsets.all(0),
        child: IconButton(
          highlightColor: Colors.blue,
          focusColor: Colors.amber,
          icon: SvgPicture.asset(
            "assets/icon/${emoji[widget.emojiIndex]}.svg",
            height: 30.0,
            width: 30.0,
          ),
          iconSize: 30,
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
