import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../../../configs/constants.dart';
import '../../../models/api/chat.dart';

class ChatAPI {
  final Dio _dio = Dio();

  Future<List<ChatModel>> getThreads({int? lastId, required String token, List<String> folders = const  ["default"]}) async {
    List<ChatModel> threads = [];
    var query = {
      "page_size": Constants.pageSizeThreads,
      "include_folders":  folders,
    };
    if (lastId != null) {
      query.addAll({"last_id": lastId});
    }
    String bearerToken = "Bearer $token";
    try {
      final result = await _dio.get("https://staging-messenger.gapowork.vn/chat/v3.3/threads",
      queryParameters: query, options: Options(
            headers: {
              "content-type": "application/json; charset=utf-8",
              "x-gapo-workspace-id": "581860791816317",
              "x-gapo-lang": "vi",
              "Authorization": bearerToken,
            }
          ));
      final data = result.data["data"];
      for(dynamic item in data){
        threads.add(ChatModel.fromJson(item));
      }
      return threads;
    } catch (e) {
      rethrow;
    }
  }

  //have no api
  Future<List<ChatModel>> getChats({required int page}) async {
    List<ChatModel> chats = [];
    //get local sample data instead of call api
    try {
      final data = await _loadDataFromAsset(
        path: 'assets/sample_data/chat_response.json',
      );
      if (data["data"] != null) {
        List<dynamic> list = data["data"];
        for (int index = 0; index < list.length; index++) {
          //handle for load more without api
          if (index >= ((page - 1) * Constants.perPageSize) &&
              index < ((page) * Constants.perPageSize)) {
            chats.add(ChatModel.fromJson(list[index] as Map<String, dynamic>));
          }
          if (chats.length == Constants.perPageSize) {
            break;
          }
        }
      }
      return chats;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChatModel>> getStoredConversations({required int page}) async {
    List<ChatModel> storedConversations = [];
    //get local sample data instead of call api
    try {
      final data = await _loadDataFromAsset(
        path: 'assets/sample_data/stored_conversation.json',
      );
      if (data["data"] != null) {
        List<dynamic> list = data["data"];
        for (int index = 0; index < list.length; index++) {
          //handle for load more without api
          if (index >= ((page - 1) * Constants.perPageSize) &&
              index < ((page) * Constants.perPageSize)) {
            storedConversations
                .add(ChatModel.fromJson(list[index] as Map<String, dynamic>));
          }
          if (storedConversations.length == Constants.perPageSize) {
            break;
          }
        }
      }
      return storedConversations;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> _loadDataFromAsset({required String path}) async {
    final String response = await rootBundle.loadString(path);
    final data = await json.decode(response);
    return data;
  }
}
