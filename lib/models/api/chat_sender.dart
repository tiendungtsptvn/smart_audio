class Sender {
  String? id;
  String? name;
  String? avatar;
  int? statusVerify;
  String? type;

  Sender({this.id, this.name, this.avatar, this.statusVerify, this.type});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    statusVerify = json['status_verify'];
    type = json['type'];
  }

}