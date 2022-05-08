import 'package:app/mock/post.dart';
import 'package:flutter/material.dart';
import 'package:app/mock/user_data.dart';
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
    List<Widget> widgets = [Profile(userData: mockUser), ...mockPosts];
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int index) {
        return widgets[index];
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class Profile extends Container {
  Profile({Key? key, required UserData userData})
      : super(
            key: key,
            width: double.infinity,
            child: Column(
              children: [
                const Placeholder(
                  color: Colors.transparent,
                  fallbackHeight: 40,
                ),
                CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 85,
                        backgroundImage: AssetImage(mockUser.avatarPath))),
                const Placeholder(
                  color: Colors.transparent,
                  fallbackHeight: 10,
                ),
                Text(userData.name,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold)),
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child:
                            Icon(Icons.explore, size: 20, color: Colors.grey),
                      ),
                      TextSpan(
                          text: ' ' + userData.introduction,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.grey)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(MdiIcons.fromString('map-marker'),
                            size: 15, color: Colors.grey),
                      ),
                      TextSpan(
                          text: ' ' + userData.address,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.grey)),
                    ],
                  ),
                ),
                const Placeholder(
                  color: Colors.transparent,
                  fallbackHeight: 20,
                ),
              ],
            ));
}
