import 'package:spotify/spotify.dart';
String getFirstImage(List<Image>? images){
  if(images == null || images.isEmpty){
    return '';
  }
  return images.first.url ?? '';
}

String artistsToString(List<Artist>? artists){
  List<String> names = [];
  if(artists == null) {
    return '';
  }
  for (var ars in artists) {
    if(ars.name != null){
      names.add(ars.name!);
    }
  }
  return names.join(', ');
}