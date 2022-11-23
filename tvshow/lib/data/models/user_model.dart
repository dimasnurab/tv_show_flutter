class UserModel {
  final dynamic expireAt;
  final dynamic requestToken;

  UserModel({this.expireAt, this.requestToken});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      expireAt: json['expires_at'], requestToken: json['request_token']);
}

class AccountModel {
  final dynamic avatar;
  final dynamic id;
  final dynamic name;
  final dynamic username;
  final dynamic token;

  AccountModel({
    this.avatar,
    this.id,
    this.name,
    this.username,
    this.token,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json, {dynamic token}) =>
      AccountModel(
        avatar: json['avatar']['gravatar']['hash'] ?? null,
        id: json['id'] ?? null,
        name: json['name'] ?? null,
        username: json['username'] ?? null,
        token: token,
      );

  factory AccountModel.fromDB(Map<String, dynamic> json) => AccountModel(
        avatar: json['avatar'] ?? null,
        id: json['id'] ?? null,
        name: json['name'] ?? null,
        username: json['username'] ?? null,
        token: json['token'] ?? null,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'name': name,
        'username': username,
        'avatar': avatar,
        'id': id,
      };
}
