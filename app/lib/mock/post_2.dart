import 'package:app/components/data_abstraction.dart';

/* Mock posts */
List<PostData> mockPosts = [
  PostData(
    avatarPath: "assets/mock/01.png",
    emojiPath: "assets/icon/twemoji_astonished-face.svg",
    author: '吃到辣椒的吉娃娃',
    stocks: <StockData>[
      StockData(
        num: 2330,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 10000,
      ),
      StockData(
        num: 2603,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 2000,
      ),
      StockData(
        num: 2002,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 300,
      ),
      StockData(
        num: 2454,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockData(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockData(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockData(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockData(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockData(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
      StockData(
        num: 2412,
        startDate: "2022/05/03",
        endDate: "2022/05/11",
        holding: 1000,
      ),
    ],
    emojiCounts: {
      "twemoji_confounded-face": 6,
      "twemoji_angry-face": 5,
      "twemoji_anguished-face": 1,
      "twemoji_cowboy-hat-face": 10,
      "twemoji_anxious-face-with-sweat": 1,
      "twemoji_astonished-face": 1,
      "twemoji_beaming-face-with-smiling-eyes": 1,
    },
    title: '跟破壞性科技相比，基金管理人就是遜啦',
    subtitle: '我的100行的Python腳本平均收益都比較高',
    publishDate: '5月11日',
  ),
  PostData(
    avatarPath: "assets/mock/01.png",
    emojiPath: "assets/icon/twemoji_beaming-face-with-smiling-eyes.svg",
    author: '後空翻的猿人',
    stocks: [],
    emojiCounts: {},
    title: '第一次0DTE就上手',
    subtitle: '散戶們，衝啊',
    publishDate: '2月26日',
  ),
];
