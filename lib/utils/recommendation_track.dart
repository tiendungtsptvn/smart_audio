import 'package:get_storage/get_storage.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:spotify/spotify.dart';

/// Store track information to storage.
void storeTrackInformation({required Track track}) {
  final storage = GetStorage();
  //Artist
  if (track.artists != null) {
    Map<String, int> artistsStored = Map<String, int>.from(storage.read(StringSAU.recentArtists) ?? {});
    for (var artist in track.artists!) {
      if (artist.id != null) {
        artistsStored.update(
          artist.id!,
          (value) => 1 + value,
          ifAbsent: () => 1,
        );
      }
    }
    storage.write(StringSAU.recentArtists, artistsStored);
  }
  //Genre
  if (track.artists != null) {
    Map<String, int> genresStored = Map<String, int>.from(storage.read(StringSAU.recentGenres) ?? {});
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
    storage.write(StringSAU.recentGenres, genresStored);
  }
  //Track
  if (track.id != null) {
    Map<String, int> tracksStored = Map<String, int>.from(storage.read(StringSAU.recentTracks) ?? {});
    tracksStored.update(
      track.id!,
      (value) => 1 + value,
      ifAbsent: () => 1,
    );
    storage.write(StringSAU.recentTracks, tracksStored);
  }
}
/// Sort and remove recommendation information.
///
void sortAndRemoveRecommendationInformation() {
  final storage = GetStorage();

  //Artist
  Map<String, int> artistsStored = Map<String, int>.from(storage.read(StringSAU.recentArtists) ?? {});
  //Order from Largest to smallest
  Map<String, int> artistsStoredSorted =
      Map.fromEntries(artistsStored.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
  //Remove lots of old data
  if (artistsStoredSorted.length > 50) {
    artistsStoredSorted =
        Map.fromEntries(artistsStoredSorted.entries.toList()..removeRange(49, artistsStoredSorted.length));
  }
  storage.write(StringSAU.recentArtists, artistsStoredSorted);

  //Genre
  Map<String, int> genresStored = Map<String, int>.from(storage.read(StringSAU.recentGenres) ?? {});
  //Order from Largest to smallest
  Map<String, int> genresStoredSorted =
  Map.fromEntries(genresStored.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
  //Remove lots of old data
  if (genresStoredSorted.length > 50) {
    genresStoredSorted =
        Map.fromEntries(genresStoredSorted.entries.toList()..removeRange(49, genresStoredSorted.length));
  }
  storage.write(StringSAU.recentGenres, genresStoredSorted);

  //Tracks
  Map<String, int> tracksStored = Map<String, int>.from(storage.read(StringSAU.recentTracks) ?? {});
  //Order from Largest to smallest
  Map<String, int> tracksStoredSorted =
  Map.fromEntries(tracksStored.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
  //Remove lots of old data
  if (tracksStoredSorted.length > 100) {
    tracksStoredSorted =
        Map.fromEntries(tracksStoredSorted.entries.toList()..removeRange(99, tracksStoredSorted.length));
  }
  storage.write(StringSAU.recentTracks, tracksStoredSorted);
}
