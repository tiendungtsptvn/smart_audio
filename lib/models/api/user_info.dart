import 'dart:convert';


UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo(
      {required this.email,
      required this.createdAt,
      required this.status,
      required this.name,
      required this.avatar});

  final String name;
  final String avatar;
  final String email;
  final int createdAt;
  int status;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
      email: json["email_address"] ?? "",
      avatar: json["avatar"] ??
          'https://cdn-thumb-image-1.gapowork.vn/312x312/smart/79a0096a-7f0a-4495-aa53-b0fddaaddc64.jpeg',
      name: json["name"] ?? "Jumper",
      createdAt: json["created_at"] ?? 0,
      status: json["status"] ?? 0);

  Map<String, dynamic> toJson() => {
        "email_address": email,
        "name": name,
        "avatar": avatar,
        "status": status,
        "created_at": createdAt,
      };

  bool isActivated() {
    return status != 0;
  }

  double weight() {
    return 60;
  }
}
