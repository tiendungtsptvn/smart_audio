import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/models_ui/models.dart';
import 'package:smart_audio/pages/home/widgets/item_audio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SAUAudio>? audios;
  SAUAudio? _selectedAudio;
  bool _isPlaying = false;
  // final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _fetchAudios();

    // _audioPlayer.onPlayerStateChanged.listen((event) {
    //   if (event == PlayerState.playing) {
    //     _isPlaying = true;
    //   } else {
    //     _isPlaying = false;
    //   }
    //   setState(() {
    //   });
    // });
  }

  _fetchAudios() async {
    try {
      final radioJson = await rootBundle.loadString("assets/data/radio.json");
      audios = SAUAudioList.fromJson(radioJson).radios;
      if (audios != null && audios!.isNotEmpty) {
        _selectedAudio = audios![0];
      }
    } catch (e) {
      audios = [];
      debugPrint("Error fetch audios__");
    }
    setState(() {});
  }

  _playMusic(String url) {
    // _audioPlayer.play(UrlSource(url));
    _selectedAudio = audios!.firstWhere((element) => element.url == url);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    SAUColor.primaryColor1,
                    SAUColor.primaryColor2,
                  ],
                ),
              ),
            ),
            AppBar(
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "Smart Audio",
                style: TextStyle(color: SAUColor.purpleLight, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
            ),
            (audios != null)
                ? Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: audios!.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        itemBuilder: (context, index) {
                          return AudioItemHome(
                            audio: audios![index],
                            onDoubleTap: (url) {
                              if(_isPlaying){
                                // _audioPlayer.pause();
                              }else{
                                _playMusic(url);
                              }
                            },
                          );
                        },
                        shrinkWrap: false,
                      ),
                    ),
                  )
                : const Center(
                    child: CupertinoActivityIndicator(),
                  ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: (!_isPlaying)
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Tap to play - ${_selectedAudio?.name}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_selectedAudio != null) {
                                _playMusic(_selectedAudio!.url);
                              }
                            },
                            child: const Icon(
                              Icons.play_circle_outline,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Playing now - ${_selectedAudio?.name}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // _audioPlayer.pause();
                            },
                            child: const Icon(Icons.pause_circle_outline, size: 40, color: Colors.white),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
