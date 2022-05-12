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

UserData mockUser = UserData(
  account: 'blueskyson',
  passward: '123456',
  name: '林政傑',
  avatarPath: 'assets/mock/01.png',
  introduction: '成功大學資訊工程系',
  address: '林口區, 新北市, 台灣',
  postNum: 3,
);
