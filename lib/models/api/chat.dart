
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../generated/locales.g.dart';
import 'chat_last_message.dart';
import 'chat_partner.dart';
import 'chat_setting.dart';

class ChatModel {
  String? name;
  bool? loading;
  int? enableNotify;
  String? role;
  String? avatar;
  int? id;
  int? groupLevel;
  int? messageCount;
  int? memberCount;
  int? banCount;
  String? folder;
  int? pinnedMessageId;
  int? readCount;
  String? type;
  String? link;
  Partner? partner;
  String? partnerId;
  LastMessage? lastMessage;
  int? pinnedAt;
  int? pinnedCount;
  int? unreadCount;
  int? canSendMessage;
  Settings? settings;

  ChatModel(
      {this.name,
      this.loading = false,
      this.enableNotify,
      this.role,
      this.avatar,
      this.id,
      this.groupLevel,
      this.messageCount,
      this.memberCount,
      this.banCount,
      this.folder,
      this.pinnedMessageId,
      this.readCount,
      this.type,
      this.link,
      this.partner,
      this.partnerId,
      this.lastMessage,
      this.pinnedAt,
      this.pinnedCount,
      this.unreadCount,
      this.canSendMessage,
      this.settings});

  ChatModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    enableNotify = json['enable_notify'];
    role = json['role'];
    avatar = json['avatar'];
    id = json['id'];
    groupLevel = json['group_level'];
    messageCount = json['message_count'];
    memberCount = json['member_count'];
    banCount = json['ban_count'];
    folder = json['folder'];
    pinnedMessageId = json['pinned_message_id'];
    readCount = json['read_count'];
    type = json['type'];
    link = json['link'];
    partner =
        json['partner'] != null ? Partner.fromJson(json['partner']) : null;
    partnerId = json['partner_id'];
    lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;
    pinnedAt = json['pinned_at'];
    pinnedCount = json['pinned_count'];
    if (json['tags'] != null) {
      json['tags'].forEach((v) {});
    }
    unreadCount = json['unread_count'];
    canSendMessage = json['can_send_message'];
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }

  bool nameContains({required String keyword}) {
    if (name != null) {
      if (name!.toLowerCase().contains(keyword.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  bool isPinned() {
    if (pinnedCount != null) {
      if (pinnedCount! > 0) {
        return true;
      }
    }
    return false;
  }

  bool isLoading() {
    if (loading != null) {
      return loading!;
    }
    return false;
  }

  bool isActive() {
    if (enableNotify != null) {
      if (enableNotify == 1) {
        return true;
      }
    }
    return false;
  }

  bool enableUnread() {
    if (unreadCount != null) {
      if (unreadCount! > 0) {
        return true;
      }
    }
    return false;
  }

  String getTimeLastMessage() {
    DateTime time = DateTime.now();
    DateTime now = DateTime.now();
    if (lastMessage?.createdAt != null) {
      time = DateTime.fromMillisecondsSinceEpoch(lastMessage!.createdAt!);
      if (now.difference(time).inSeconds < 60) {
        return LocaleKeys.chat_justFinished.tr;
      } else if (now.difference(time).inMinutes < 60) {
        return "${now.difference(time).inMinutes} ${LocaleKeys.chat_minutes.tr}";
      } else if (now.difference(time).inHours < 24) {
        return "${now.difference(time).inHours} ${LocaleKeys.chat_hour.tr}";
      } else {
        return DateFormat("dd TMM").format(time);
      }
    }
    return "";
  }

  int getUnreadMessage() {
    if (enableUnread()) {
      if (unreadCount! > 9) {
        return 9;
      } else {
        return unreadCount!;
      }
    }
    return 0;
  }
}
