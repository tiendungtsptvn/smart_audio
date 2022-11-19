


import 'chat_meta_data.dart';

class RawBody {
  String? text;
  String? type;
  ChatMetadata? metadata;
  bool? isMarkdownText;

  RawBody(
      {this.text,
        this.type,
        this.metadata,
        this.isMarkdownText});

  RawBody.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
    isMarkdownText = json['is_markdown_text'];
  }

}