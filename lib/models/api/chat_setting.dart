class Settings {
  int? isPublic;
  int? disableMemberSendMessage;

  Settings({this.isPublic, this.disableMemberSendMessage});

  Settings.fromJson(Map<String, dynamic> json) {
    isPublic = json['is_public'];
    disableMemberSendMessage = json['disable_member_send_message'];
  }

}