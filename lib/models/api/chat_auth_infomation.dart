class AuthInformation {
  String? deviceId;
  int? createdAt;
  String? requestIp;
  String? userAgent;

  AuthInformation(
      {this.deviceId, this.createdAt, this.requestIp, this.userAgent});

  AuthInformation.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    createdAt = json['created_at'];
    requestIp = json['request_ip'];
    userAgent = json['user_agent'];
  }

}