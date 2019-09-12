class UserInfo {
   String userId;
   String userName;
   String userPhone;

  UserInfo({this.userId, this.userName, this.userPhone});
  ///获取UserInfo的实例
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        userId: json['userId'],
        userName: json['userName'],
        userPhone: json['userPhone']);
  }
}
