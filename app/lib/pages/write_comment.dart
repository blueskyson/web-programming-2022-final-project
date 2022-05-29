import 'package:app/components/comment_box.dart';
import 'package:flutter/material.dart';
import 'package:app/global_variables.dart';
import 'package:app/mock/comment_card.dart';
import 'package:app/mock/user_data.dart';

class WriteCommentPage extends StatefulWidget {
  const WriteCommentPage({Key? key}) : super(key: key);
  @override
  _WriteCommentPageState createState() => _WriteCommentPageState();
}

class _WriteCommentPageState extends State<WriteCommentPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: Container(
                height: 50.0,
                width: 50.0,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  backgroundImage: AssetImage(
                    data[i]['avatarPath'],
                  ),
                ),
              ),
              title: Text(
                data[i]['author'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                data[i]['message'],
              ),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: navbarColor,
        title: const Text("留言"),
      ),
      body: CommentBox(
        avatarPath: mockUser.avatarPath,
        child: commentChild(mockComments),
        labelText: '寫下您的留言',
        errorText: '留言不能空為空',
        withBorder: false,
        sendButtonMethod: () {
          if (formKey.currentState!.validate()) {
            setState(() {
              var value = {
                'author': mockUser.name,
                'avatarPath': mockUser.avatarPath,
                'message': commentController.text
              };
              mockComments.insert(0, value);
            });
            commentController.clear();
            FocusScope.of(context).unfocus();
          }
        },
        formKey: formKey,
        commentController: commentController,
        backgroundColor: navbarColor,
        textColor: Colors.black,
        sendWidget: const Icon(
          Icons.send_sharp,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
