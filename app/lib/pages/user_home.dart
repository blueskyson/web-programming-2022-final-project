import 'package:flutter/material.dart';
import 'package:app/mock/notification_card.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: mockNotifications.length,
      itemBuilder: (BuildContext context, int index) {
        return mockNotifications[index];
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
