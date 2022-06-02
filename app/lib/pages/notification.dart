import 'package:flutter/material.dart';
import 'package:app/mock/notification_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with AutomaticKeepAliveClientMixin<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: mockNotifications.length,
      itemBuilder: (BuildContext context, int index) {
        return mockNotifications[index];
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
