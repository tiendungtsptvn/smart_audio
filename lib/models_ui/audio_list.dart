import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'audio.dart';

class SAUAudioList {
  final List<SAUAudio> radios;
  SAUAudioList({
    required this.radios,
  });

  SAUAudioList copyWith({
    List<SAUAudio>? radios,
  }) {
    return SAUAudioList(
      radios: radios ?? this.radios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radios': radios.map((x) => x.toMap()).toList(),
    };
  }

  factory SAUAudioList.fromMap(Map<String, dynamic> map) {
    return SAUAudioList(
      radios: List<SAUAudio>.from(map['radios']?.map((x) => SAUAudio.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SAUAudioList.fromJson(String source) =>
      SAUAudioList.fromMap(json.decode(source));

  @override
  String toString() => 'SAUAudioList(radios: $radios)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SAUAudioList && listEquals(other.radios, radios);
  }

  @override
  int get hashCode => radios.hashCode;
}