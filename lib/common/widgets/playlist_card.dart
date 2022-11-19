import 'package:flutter/material.dart';
import 'package:smart_audio/base/widgets/animated_shimmer.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:spotify/spotify.dart' as spotify;


class PlaylistCardItem extends StatelessWidget {
  const PlaylistCardItem({
    Key? key,
    required this.playlistSimple,
    required this.onTap,

  }) : super(key: key);

  final spotify.PlaylistSimple playlistSimple;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLoading = playlistSimple.id == null;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.topCenter,
        width: SAUDouble.playlistCardWidth,
        height: SAUDouble.playlistCardHeight,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SAUDouble.playlistCardBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 7), // changes position of shadow
              ),
            ]),
        child: Column(
          children: [
            SizedBox(
              width: SAUDouble.playlistCardWidth,
              height: SAUDouble.playlistCardWidth,
              child: Stack(
                children: [
                  //Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(SAUDouble.playlistCardBorder),
                    child: (isLoading)
                        ? const AnimatedShimmer(
                            width: SAUDouble.playlistCardWidth,
                            height: SAUDouble.playlistCardWidth,
                            radius: SAUDouble.playlistCardBorder,
                          )
                        : Image.network(
                            (playlistSimple.images != null && playlistSimple.images!.isNotEmpty)
                                ? playlistSimple.images!.first.url ?? ''
                                : "",
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                StringSAU.defaultImage,
                                fit: BoxFit.fill,
                              );
                            },
                          ),
                  ),
                  if (!isLoading)
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 40,
                      ),
                    )
                ],
              ),
            ),
            //Title
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 180,
                  child: (isLoading)
                      ? const AnimatedShimmer(
                          width: 150,
                          height: 15,
                          radius: 5,
                        )
                      : Text(
                          playlistSimple.name ?? '',
                          style: SAUStyle.textStyleNormal,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
