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
