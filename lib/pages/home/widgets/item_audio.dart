import 'package:flutter/material.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/models_ui/models.dart';

class AudioItemHome extends StatelessWidget {
  const AudioItemHome({
    Key? key,
    required this.audio,
    required this.onDoubleTap,
  }) : super(key: key);
  final SAUAudio audio;
  final Function(String url) onDoubleTap;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.only(right: 50),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  audio.image,
                )),
            border: Border.all(
              color: Colors.black,
              width: SAUDouble.borderItem,
            ),
            borderRadius: BorderRadius.circular(SAUDouble.radiusAudioItem)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onDoubleTap: (){
                    onDoubleTap(audio.url);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.play_circle_outline, color: Colors.white, size: 30),
                      Text(
                        "Double tap to play",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        audio.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        audio.tagline ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
