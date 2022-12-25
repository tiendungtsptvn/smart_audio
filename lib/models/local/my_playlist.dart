class MyPlaylist {
  String name;
  List<String> tracks;
  MyPlaylist({required this.name, required this.tracks});

  static MyPlaylist fromJson(Map<String, dynamic> json){
    return MyPlaylist(
        name: json['name'],
        tracks: (json['tracks'] as List).map((e) => e.toString()).toList());
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'tracks': tracks,
    };
  }
}