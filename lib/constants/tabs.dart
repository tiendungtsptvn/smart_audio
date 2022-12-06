import 'package:flutter/cupertino.dart';
import 'package:smart_audio/screens/chats/chats_screen.dart';
import 'package:smart_audio/screens/home/home_screen.dart';
import 'package:smart_audio/screens/search/search_screen.dart';

import '../screens/setting/setting_screen.dart';

const List<Widget> tabsApp = <Widget>[
  HomeScreen(),
  SearchScreen(),
  ChatsScreen(),
  SettingScreen(),
];