import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
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
    String name = playlistSimple.name ?? '';
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.topCenter,
        width: SAUDouble.playlistCardWidth,
        height: SAUDouble.playlistCardHeight,
        decoration: BoxDecoration(
            color: ColorSAU.backgroundCard,
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
                     Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 40,
                        color: ColorSAU.secondaryColor,
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
                      : (name.length <= 20)
                          ? Text(
                              name,
                              style: SAUStyle.textStyleNormal,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            )
                          : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Marquee(
                                text: name,
                                style: SAUStyle.textStyleNormal,
                                scrollAxis: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                blankSpace: 20.0,
                                velocity: 100.0,
                                pauseAfterRound: const Duration(seconds: 5),
                                startPadding: 10.0,
                                accelerationDuration: const Duration(seconds: 2),
                                accelerationCurve: Curves.linear,
                                decelerationDuration: const Duration(milliseconds: 500),
                                decelerationCurve: Curves.easeOut,
                              ),
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
