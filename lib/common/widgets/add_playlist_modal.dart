import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/screens/my_playlist/my_playlist_controller.dart';
import 'package:smart_audio/theme/colors.dart';
import 'package:smart_audio/theme/text_theme.dart';
import 'package:spotify/spotify.dart';

class AddPlaylistModal extends GetView<MyPlaylistController> {
  const AddPlaylistModal({Key? key, required this.track}) : super(key: key);
  final TrackSimple track;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                    child: const Text('Cancel', style: TextStyle(fontSize: SAUDouble.fontSizeNormal),),
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
              ),
              const Spacer(),
              const Text(
                'Your playlists',
                style: TextStyle(fontSize: SAUDouble.fontSizeNormal),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  _showPlaylistNameDialog(context);
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: ColorSAU.textDarkWhite,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () {
                  if (controller.myPlaylists.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Center(
                        child: Text("Create your playlist", style: TextStyle(fontSize: 25)),
                      ),
                    );
                  }
                  return Column(
                    children: List.generate(
                        controller.myPlaylists.length,
                        (index) => ListTile(
                              leading: Text((index + 1).toString(),
                                style: const TextStyle(fontSize: SAUDouble.fontSizeNormal),),
                              title: Text(
                                controller.myPlaylists[index].name,
                                style: const TextStyle(fontSize: SAUDouble.fontSizeNormal),
                              ),
                              trailing: const Icon(
                                Icons.playlist_add,
                                color: ColorSAU.textDarkWhite,
                              ),
                              onTap: () {
                                controller.addTrackToPlaylist(
                                    playlistName: controller.myPlaylists[index].name, trackId: track.id);
                                Navigator.of(context).pop();
                              },
                            )).toList(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showPlaylistNameDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Playlist name")),
          content: TextFormField(
            controller: textEditingController,
            textInputAction: TextInputAction.search,
            style: textStyle(GPTypography.body16)?.copyWith(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              fillColor: GPColor.textFieldBkg,
              hintText: "Playlist name",
            ),
            autocorrect: false,
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: ColorSAU.secondaryColor),
                onPressed: () {
                  if (textEditingController.text.isNotEmpty) {
                    if (controller.myPlaylists
                            .firstWhereOrNull((element) => element.name == textEditingController.text.trim()) ==
                        null) {
                      Navigator.of(context).pop(textEditingController.text.trim());
                    }
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: ColorSAU.textDarkWhite),
                ))
          ],
        );
      },
    ).then((value) {
      if(value != null){
        controller.addNewPlaylist(value);
      }
    });
  }
}
