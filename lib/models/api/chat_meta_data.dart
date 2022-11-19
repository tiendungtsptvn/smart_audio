
import 'chat_auth_infomation.dart';

class ChatMetadata {
  AuthInformation? authInformation;

  ChatMetadata({this.authInformation});

  ChatMetadata.fromJson(Map<String, dynamic> json) {
    authInformation = json['auth_information'] != null
        ? AuthInformation.fromJson(json['auth_information'])
        : null;
  }
}