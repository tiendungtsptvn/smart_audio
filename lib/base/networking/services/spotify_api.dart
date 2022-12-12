import 'package:spotify/spotify.dart';

class SpotifyService {
  final SpotifyApi spotifyApi;

  SpotifyService({required this.spotifyApi});

  Future<List<PlaylistSimple>> getFeaturedPlaylist() async {
    try {
      Page<PlaylistSimple> playlists = await spotifyApi.playlists.featured.getPage(8, 1);
      return (playlists.items ?? []).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<PlaylistSimple>> getPlaylistsById(String id) async {
    List<PlaylistSimple> playlists = [];
    try {
      await spotifyApi.playlists.getByCategoryId(id).all(20).then((value){
        playlists.addAll(value);
      });
      return playlists;
    } catch (_) {
      rethrow;
    }
  }

  Future<Playlist> getPlaylist({required String playlistId}) async {
    try {
      Playlist playlist = await spotifyApi.playlists.get(playlistId);
      return playlist;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Track>> getTracksInPlaylist({required String playlistId}) async {
    try {
      List<Track> tracks =
          await spotifyApi.playlists.getTracksByPlaylistId(playlistId).all().then((value) => value.toList());
      return tracks;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Track>> searchTracks({required String keyword}) async {
    List<Track> tracks = [];
    try {
      await spotifyApi.search.get(keyword, types: [SearchType.track]).getPage(30, 0).then((value) {
            if (value.single.items != null) {
              for (var item in value.single.items!) {
                if (item is Track) {
                  if (item.previewUrl != null) {
                    tracks.add(item);
                  }
                }
              }
            }
            // return tracks;
          });
      return tracks;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<TrackSimple>> getRecommendationTracks({
    required List<String>? seedGenres,
    required List<String>? seedArtists,
    required List<String>? seedTracks,
  }) async {
    List<TrackSimple> tracks = [];
    try {
      await spotifyApi.recommendations.get(
        seedArtists: seedArtists,
        seedGenres: seedGenres,
        seedTracks: seedTracks,
        limit: 50,
        max: {},
        min: {},
        target: {},
      ).then((value) {
        if(value.tracks != null){
          for(var track in value.tracks!){
            if(track.previewUrl != null){
              tracks.add(track);
            }
          }
        }
      });
      return tracks;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Track>> getSeveralTracks({required List<String> trackIds}) async{
    List<Track> tracks = [];
    try{
      await spotifyApi.tracks.list(trackIds).then((value) => tracks.addAll(value));
      return tracks;
    }catch(_){
      rethrow;
    }
  }

}
