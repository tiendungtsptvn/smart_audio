
import 'package:get_storage/get_storage.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:spotify/spotify.dart';

/// Store track information to storage.
void storeTrackInformation({required Track track}) {
  final storage = GetStorage();
  //Artist
  if (track.artists != null) {
    Map<String, int> artistsStored = Map<String, int>.from(storage.read(StringSAU.recentArtistsKeyStore) ?? {});
    for (var artist in track.artists!) {
      if (artist.id != null) {
        artistsStored.update(
          artist.id!,
          (value) => 1 + value,
          ifAbsent: () => 1,
        );
      }
    }
    storage.write(StringSAU.recentArtistsKeyStore, artistsStored);
  }
  //Genre
  if (track.artists != null) {
    Map<String, int> genresStored = Map<String, int>.from(storage.read(StringSAU.recentGenresKeyStore) ?? {});
    for (var artist in track.artists!) {
      if (artist.genres != null) {
        for (var genre in artist.genres!) {
          genresStored.update(
            genre,
            (value) => 1 + value,
            ifAbsent: () => 1,
          );
        }
      }
    }
    storage.write(StringSAU.recentGenresKeyStore, genresStored);
  }
  //Track
  if (track.id != null) {
    Map<String, int> tracksStored = Map<String, int>.from(storage.read(StringSAU.recentTracksKeyStore) ?? {});
    tracksStored.update(
      track.id!,
      (value) => 1 + value,
      ifAbsent: () => 1,
    );
    storage.write(StringSAU.recentTracksKeyStore, tracksStored);
  }
}
/// Sort and remove recommendation information.
///
void sortAndRemoveRecommendationInformation() {
  final storage = GetStorage();

  //Artist
  Map<String, int> artistsStored = Map<String, int>.from(storage.read(StringSAU.recentArtistsKeyStore) ?? {});
  //Order from Largest to smallest
  Map<String, int> artistsStoredSorted =
      Map.fromEntries(artistsStored.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
  //Remove lots of old data
  if (artistsStoredSorted.length > 50) {
    artistsStoredSorted =
        Map.fromEntries(artistsStoredSorted.entries.toList()..removeRange(49, artistsStoredSorted.length));
  }
  storage.write(StringSAU.recentArtistsKeyStore, artistsStoredSorted);

  //Genre
  Map<String, int> genresStored = Map<String, int>.from(storage.read(StringSAU.recentGenresKeyStore) ?? {});
  //Order from Largest to smallest
  Map<String, int> genresStoredSorted =
  Map.fromEntries(genresStored.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
  //Remove lots of old data
  if (genresStoredSorted.length > 50) {
    genresStoredSorted =
        Map.fromEntries(genresStoredSorted.entries.toList()..removeRange(49, genresStoredSorted.length));
  }
  storage.write(StringSAU.recentGenresKeyStore, genresStoredSorted);

  //Tracks
  Map<String, int> tracksStored = Map<String, int>.from(storage.read(StringSAU.recentTracksKeyStore) ?? {});
  //Order from Largest to smallest
  Map<String, int> tracksStoredSorted =
  Map.fromEntries(tracksStored.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
  //Remove lots of old data
  if (tracksStoredSorted.length > 100) {
    tracksStoredSorted =
        Map.fromEntries(tracksStoredSorted.entries.toList()..removeRange(99, tracksStoredSorted.length));
  }
  storage.write(StringSAU.recentTracksKeyStore, tracksStoredSorted);
}

List<String> getSeedData({required GetStorage storage, bool genres = false, bool artists = false, bool tracks = false,}){
  Map<String, int> artistsData = {};
  if(artists){
    artistsData = storage.read(StringSAU.recentArtistsKeyStore);
  }
  if(genres){
    artistsData = storage.read(StringSAU.recentGenresKeyStore);

  }
  if(tracks){
    artistsData = storage.read(StringSAU.recentTracksKeyStore);
  }
  if(artistsData.keys.isNotEmpty){
    return [artistsData.keys.first];
  }
  return [];
}
