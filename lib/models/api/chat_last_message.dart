

import 'chat_raw_body.dart';
import 'chat_sender.dart';

class LastMessage {
  int? id;
  String? body;
  RawBody? rawBody;
  Sender? sender;
  int? createdAt;
  String? userId;

  LastMessage(
      {this.id,
        this.body,
        this.rawBody,
        this.sender,
        this.createdAt,
        this.userId});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    rawBody = json['raw_body'] != null
        ? RawBody.fromJson(json['raw_body'])
        : null;
    sender =
    json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    createdAt = json['created_at'];
    userId = json['user_id'];
  }

}