import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final Widget? child;
  final dynamic formKey;
  final dynamic sendButtonMethod;
  final dynamic commentController;
  final String? avatarPath;
  final String? labelText;
  final String? errorText;
  final Widget? sendWidget;
  final Color? backgroundColor;
  final Color? textColor;
  final bool withBorder;
  final Widget? header;
  final FocusNode? focusNode;

  const CommentBox({
    Key? key,
    this.child,
    this.header,
    this.sendButtonMethod,
    this.formKey,
    this.commentController,
    this.sendWidget,
    this.avatarPath,
    this.labelText,
    this.focusNode,
    this.errorText,
    this.withBorder = true,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child!),
        const Divider(
          height: 1,
        ),
        header ?? const SizedBox.shrink(),
        ListTile(
          tileColor: backgroundColor,
          leading: Container(
            height: 40.0,
            width: 40.0,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              backgroundImage: AssetImage(avatarPath!),
            ),
          ),
          title: Form(
            key: formKey,
            child: TextFormField(
              maxLines: 4,
              minLines: 1,
              focusNode: focusNode,
              cursorColor: textColor,
              style: TextStyle(color: textColor),
              controller: commentController,
              decoration: InputDecoration(
                enabledBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: textColor!,
                        ),
                      ),
                focusedBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: textColor!,
                        ),
                      ),
                border: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: textColor!,
                        ),
                      ),
                labelText: labelText,
                focusColor: textColor,
                fillColor: textColor,
                labelStyle: TextStyle(color: textColor),
              ),
              validator: (value) => value!.isEmpty ? errorText : null,
            ),
          ),
          trailing: GestureDetector(
            onTap: sendButtonMethod,
            child: sendWidget,
          ),
        ),
      ],
    );
  }
}
