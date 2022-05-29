import 'package:flutter/material.dart';
import 'package:app/utils/time.dart';

class NotificationCard extends ListTile {
  final String avatarPath, message, timestamp;
  NotificationCard({
    Key? key,
    required this.avatarPath,
    required this.message,
    required this.timestamp,
  }) : super(
          key: key,
          leading: Image(
            image: AssetImage(avatarPath),
          ),
          title: Text(
            message,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            timestamp,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          trailing: const Icon(
            Icons.more_vert,
          ),
        );
}

List<NotificationCard> mockNotifications = [
  NotificationCard(
    avatarPath: 'assets/mock/user1.png',
    message: '我為一家公司投資 100 美元，該公司的預期收益為 4 美元。 預期的增長可以說是每年 10%。...',
    timestamp: getCurrentTime(),
  ),
  NotificationCard(
    avatarPath: 'assets/mock/user2.png',
    message: '伊隆馬斯克計劃解僱 1000 名推特員工',
    timestamp: getCurrentTime(),
  ),
  NotificationCard(
    avatarPath: 'assets/mock/user3.png',
    message: '分析師似乎遠遠落後於曲線，許多人預測本季度的銷售額仍將超過 30 萬，儘管上海停工和其他供...',
    timestamp: getCurrentTime(),
  ),
];
