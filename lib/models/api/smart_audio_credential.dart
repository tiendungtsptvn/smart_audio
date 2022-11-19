class SmartAudioCredential {
  String clientId;
  String accessToken;
  DateTime expiration;
  bool isAnonymous;

  SmartAudioCredential({
    required this.clientId,
    required this.accessToken,
    required this.expiration,
    required this.isAnonymous,
  });

  SmartAudioCredential.fromJson(Map<String, dynamic> json)
      : clientId = json['clientId'],
        accessToken = json['accessToken'],
        expiration = DateTime.fromMillisecondsSinceEpoch(
          json['accessTokenExpirationTimestampMs'],
        ),
        isAnonymous = json['isAnonymous'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'clientId': clientId,
      'accessToken': accessToken,
      'accessTokenExpirationTimestampMs': expiration.millisecondsSinceEpoch,
      'isAnonymous': isAnonymous,
    };
  }
}
