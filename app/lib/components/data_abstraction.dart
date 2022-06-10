class UserData {
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

class EmojiCounts {
  final List<int> counts;

  EmojiCounts({required this.counts});

  Map<String, dynamic> toJson() {
    return {
      "twemoji_confounded-face": counts[0],
      "twemoji_angry-face": counts[1],
      "twemoji_anguished-face": counts[2],
      "twemoji_cowboy-hat-face": counts[3],
      "twemoji_anxious-face-with-sweat": counts[4],
      "twemoji_astonished-face": counts[5],
      "twemoji_beaming-face-with-smiling-eyes": counts[6],
    };
  }
}

class PostData {
  int moodId;
  String author;
  List<StockData> stocks;
  Map<String, int> emojiCounts;
  String message;
  String publishDate;

  PostData({
    required this.moodId,
    required this.author,
    required this.stocks,
    required this.emojiCounts,
    required this.message,
    required this.publishDate,
  });
}
