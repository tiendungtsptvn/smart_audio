import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/color.dart';
import 'package:smart_audio/screens/my_playlist/my_playlist_controller.dart';
import 'package:smart_audio/screens/my_playlist/widgets/playlist_tile.dart';

class MyPlaylistScreen extends GetView<MyPlaylistController> {
  const MyPlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Playlist',
          style: TextStyle(
            color: ColorSAU.textGrey,
          ),
        ),
        backgroundColor: ColorSAU.primaryColor,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: ColorSAU.secondaryColor,
          ),
        ),
      ),
      body: Obx(
        () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 20),
                child: Text(
                  'You have ${controller.myPlaylists.length} playlist(s)',
                ),
              ),
              Expanded(
                child: (controller.myPlaylists.isEmpty)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.library_music, size: 50, color: ColorSAU.textGreyLight),
                            Text('Your playlist', style: TextStyle(fontSize: 22, color: ColorSAU.textGreyLight)),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return MyPlaylistTile(
                              playlist: controller.myPlaylists[index],
                              onTap: () {
                                controller.goToMyPlaylistScreen(playlist: controller.myPlaylists[index]);
                              },
                            );
                          },
                          itemCount: controller.myPlaylists.length,
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
