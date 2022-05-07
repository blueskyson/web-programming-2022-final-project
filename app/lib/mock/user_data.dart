class UserData {
  String name;
  String avatarPath;
  String introduction;
  String address;
  int postNum;

  UserData(
      {this.name = 'unknown',
      this.introduction = '',
      this.avatarPath = 'assets/pic/default_avatar.png',
      this.address = '未提供地址',
      this.postNum = 0});
}

class Post {}

UserData mockUser = UserData(
    name: '林政傑',
    avatarPath: 'assets/mock/user1.png',
    introduction: '成功大學資訊工程系',
    address: '林口區, 新北市, 台灣',
    postNum: 3);
