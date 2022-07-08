import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/cache.dart';
import 'package:app/components/data_abstraction.dart';
import 'package:app/components/user_home_post.dart';
import 'package:app/pages/write_post.dart';
import 'package:flutter/material.dart';
import 'package:app/mock/user.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    // Profile, Post[0], Post[1], ...

    return FutureBuilder<String>(
      future: getPostHistory(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> widgets = [
          Profile(userData: mockUser),
        ];

        if (snapshot.hasData) {
          // Empty post
          if (snapshot.data == "EMPTY") {
            for (int i = 0; i < 1; i++) {
              widgets.add(
                const Center(
                  child: Text("尚未發表貼文"),
                ),
              );
            }
          }

          // Load posts
          else {
            for (int i = 0; i < postHistory.length; i++) {
              widgets.add(
                UserHomePost(
                  postID: postHistory[i],
                ),
              );
            }
          }

          return ListView.separated(
            itemCount: widgets.length,
            itemBuilder: (BuildContext context, int index) {
              return widgets[index];
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        } else {
          widgets.add(
            const Center(
              child: Text("正在載入貼文..."),
            ),
          );
          return ListView.separated(
            itemCount: widgets.length,
            itemBuilder: (BuildContext context, int index) {
              return widgets[index];
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Profile extends StatelessWidget {
  final UserData userData;

  const Profile({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            children: [
              const Placeholder(
                color: Colors.transparent,
                fallbackHeight: 40,
              ),

              // User avatar
              CircleAvatar(
                radius: 90,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 85,
                  backgroundImage: AssetImage(mockUser.avatarPath),
                ),
              ),

              const Placeholder(
                color: Colors.transparent,
                fallbackHeight: 10,
              ),

              // User name
              Text(
                userData.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(
                        Icons.explore,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: ' ' + userData.introduction,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // User info
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        MdiIcons.fromString(
                          'map-marker',
                        ),
                        size: 15,
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: ' ' + userData.address,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Placeholder(
                color: Colors.transparent,
                fallbackHeight: 20,
              ),
            ],
          ),

          // Write a post
          Positioned(
            right: 0,
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: 40,
                margin: const EdgeInsets.all(0),
                child: IconButton(
                  icon: Icon(MdiIcons.fromString("pencil")),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const WritePostPage(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
