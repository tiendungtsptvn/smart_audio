class Partner {
  String? id;
  String? name;
  String? avatar;
  int? statusVerify;
  String? type;
  int? readCount;

  Partner(
      {this.id,
        this.name,
        this.avatar,
        this.statusVerify,
        this.type,
        this.readCount});

  Partner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    statusVerify = json['status_verify'];
    type = json['type'];
    readCount = json['read_count'];
  }

}