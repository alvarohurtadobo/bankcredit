import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/bank/model/video.dart';
import 'package:credidiunsa_app/bank/model/promo.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/bank/bloc/getPromos.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/bank/ui/components/promoCards.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({Key? key}) : super(key: key);

  @override
  _PromotionsPageState createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  List<String> youtubeIds = ["niK0OXiJBXQ"];

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: youtubeIds.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    super.initState();
    API.getVideos().then((res) {
      if (res.idError == 0) {
        myVideos = res.myBody["Lista"]
            .map<Video>((elem) => Video.fromBackendResponse(elem))
            .toList();
        youtubeIds = myVideos.map<String>((e) => e.youtubeId).toList();
        // print("Sending  to youtube (${youtubeIds.length}): ${youtubeIds.first}");
        // _controller.load(youtubeIds.first);
        // _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        onExitFullScreen: () {
          // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
          // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _controller.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                // log('Settings Tapped!');
              },
            ),
          ],
          onReady: () {
            _isPlayerReady = true;
          },
          onEnded: (data) {
            _controller.load(youtubeIds[
                (youtubeIds.indexOf(data.videoId) + 1) % youtubeIds.length]);
            // _showSnackBar('Next Video Started!');
          },
        ),
        builder: (context, player) => Scaffold(
              drawer: MyDrawer(),
              appBar: myAppBar(context),
              body: Container(
                color: const Color(0xffE8E8E8),
                padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 3 * Sizes.boxSeparation,
                    ),
                    const Text("Promociones",
                        style: TextStyle(
                            color: Color(0xff0F62A4),
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                    const Text("y novedades",
                        style:
                            TextStyle(color: Color(0xff0F62A4), fontSize: 20)),
                    SizedBox(
                      height: 3 * Sizes.boxSeparation,
                    ),
                    FutureBuilder(
                        future: getPromosAndNovels(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print("I have promos");
                            return Column(
                              children: [
                                SizedBox(
                                  height: Sizes.height / 5,
                                  width: double.infinity,
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: myPromos
                                          .map((prom) =>
                                              promoCard(context, prom))
                                          .toList()),
                                ),
                                SizedBox(
                                  height: 2 * Sizes.boxSeparation,
                                ),
                                SizedBox(
                                  height: Sizes.height / 5,
                                  width: double.infinity,
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: myNovelties
                                          .map((prom) =>
                                              promoCard(context, prom))
                                          .toList()),
                                ),
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                    SizedBox(
                      height: 1 * Sizes.boxSeparation,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.boxSeparation,
                          vertical: Sizes.padding * 0.7),
                      child: Text(
                        "Latest from DIUNSA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.font10),
                      ),
                    ),
                    player
                  ],
                ),
              ),
            ));
  }

  Widget newsBox(String title, String author, String views, String releaseDate,
      String assetImage) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
      color: Colors.white,
      width: Sizes.width * 0.7,
      height: Sizes.width * 0.7 * 0.7,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          width: Sizes.width * 0.7,
          height: Sizes.width * 0.7 * 0.7 * 0.7,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(assetImage), fit: BoxFit.cover)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Sizes.boxSeparation),
          child: Row(
            children: [
              Container(
                width: Sizes.width * 0.7 * 0.7 * 0.15,
                height: Sizes.width * 0.7 * 0.7 * 0.15,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/demo/image_13.png"))),
              ),
              SizedBox(
                width: Sizes.width * 0.7 * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(author),
                        Text(views),
                        Text(releaseDate),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
