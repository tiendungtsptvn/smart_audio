

import 'package:spotify/spotify.dart';


class SpotifyService {

  final SpotifyApi spotifyApi;

  SpotifyService({required this.spotifyApi});

  Future<List<PlaylistSimple>> getFeaturedPlaylist() async{
    try{
      Page<PlaylistSimple> playlists = await spotifyApi.playlists.featured.getPage(8, 1);
      return (playlists.items ?? []).toList();
    }catch(_){
      rethrow;
    }
  }

  Future<Playlist> getPlaylist({required String playlistId}) async{
    try{
      Playlist playlist = await spotifyApi.playlists.get(playlistId);
      return playlist;
    }catch(_){
      rethrow;
    }
  }

  Future<List<Track>> getTracksInPlaylist({required String playlistId}) async{
    try{
      List<Track> tracks = await spotifyApi.playlists.getTracksByPlaylistId(playlistId).all().then((value) => value.toList());
      return tracks;
    }catch(_){
      rethrow;
    }
  }

}
