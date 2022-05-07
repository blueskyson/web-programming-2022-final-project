import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCard extends ListTile {
  final String imagePath, message, timestamp;
  NotificationCard(
      {Key? key,
      this.imagePath = 'assets/mock/user1.png',
      this.message = '',
      this.timestamp = '2022/01/01 9:30'})
      : super(
          key: key,
          leading: Image(image: AssetImage(imagePath)),
          title: Text(
            message,
            style: const TextStyle(fontSize: 15),
          ),
          subtitle: Text(timestamp,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          trailing: const Icon(Icons.more_vert),
        );
}

String getCurrentTime() {
  return DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
}

List<NotificationCard> mockNotifications = [
  NotificationCard(
      imagePath: 'assets/mock/user1.png',
      message: '我為一家公司投資 100 美元，該公司的預期收益為 4 美元。 預期的增長可以說是每年 10%。...',
      timestamp: getCurrentTime()),
  NotificationCard(
      imagePath: 'assets/mock/user2.png',
      message: '伊隆馬斯克計劃解僱 1000 名推特員工',
      timestamp: getCurrentTime()),
  NotificationCard(
      imagePath: 'assets/mock/user3.png',
      message: '分析師似乎遠遠落後於曲線，許多人預測本季度的銷售額仍將超過 30 萬，儘管上海停工和其他供...',
      timestamp: getCurrentTime()),
];
