class UserData {
  int id;
  String account;
  String passward;
  String name;
  String avatarPath;
  String introduction;
  String address;
  int postNum;

  UserData({
    required this.account,
    required this.passward,
    this.id = 0,
    this.name = 'unknown',
    this.introduction = '',
    this.avatarPath = 'assets/pic/default_avatar.png',
    this.address = '未提供地址',
    this.postNum = 0,
  });
}

class StockData {
  int num;
  String startDate;
  String endDate;
  int holding;

  StockData({
    required this.num,
    required this.startDate,
    required this.endDate,
    required this.holding,
  });

  Map<String, dynamic> toJson() {
    return {
      "num": num,
      "startDate": startDate,
      "endDate": endDate,
      "holding": holding,
    };
  }
}

class PostData {
  String avatarPath;
  String emojiPath;
  String author;
  List<StockData> stocks;
  Map<String, int> emojiCounts;
  String title;
  String subtitle;
  String publishDate;

  PostData({
    required this.avatarPath,
    required this.emojiPath,
    required this.author,
    required this.stocks,
    required this.emojiCounts,
    required this.title,
    required this.subtitle,
    required this.publishDate,
  });
}
