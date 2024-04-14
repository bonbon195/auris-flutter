import 'package:auris/model/track.dart';
import 'package:auris/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Track>? tracks;
  List<Widget> trackTiles = List<Widget>.empty();
  AudioPlayer audioPlayer = AudioPlayer();
  ScrollController controller = ScrollController();
  int currentTrack = 0;
  @override
  void initState() {
    try {
      _updateTracksList();
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
            backgroundColor:
                CupertinoColors.systemGroupedBackground.resolveFrom(context),
            child: CustomScrollView(
              controller: controller,
              slivers: [
                const CupertinoSliverNavigationBar(
                  backgroundColor: CupertinoColors.secondarySystemFill,
                  largeTitle: Text("Избранное"),
                ),
                tracks == null
                    ? const SliverFillRemaining(
                        child: Center(
                          child: CupertinoActivityIndicator(
                            animating: true,
                          ),
                        ),
                      )
                    : trackTiles.isEmpty
                        ? SliverFillRemaining(
                            child: Center(
                              child: Text(
                                "У вас нет избранных треков",
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle,
                              ),
                            ),
                          )
                        : SliverPadding(
                            padding: const EdgeInsets.only(bottom: 120),
                            sliver: SliverList.list(
                              children: [
                                CupertinoListSection.insetGrouped(
                                  topMargin: 0,
                                  children: trackTiles,
                                ),
                              ],
                            ),
                          ),
              ],
            ));
      },
    );
  }

  void _generateTrackListTiles() {
    trackTiles = tracks == null
        ? const []
        : tracks!.indexed
            .map((e) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    debugPrint(e.$2.audioSourceFile);
                    await _onPressed(e.$2);
                  },
                  child: CupertinoListTile(
                    leading: e.$2.artworkFile == null || e.$2.artworkFile == ''
                        ? const Icon(CupertinoIcons.music_note_2,
                            color: CupertinoColors.activeBlue)
                        : Image.network(ApiService.getTrackArtworkUrl(e.$2)),
                    title: Text(
                      e.$2.title ?? '',
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    ),
                    subtitle: Text(e.$2.artist ?? '',
                        style: CupertinoTheme.of(context).textTheme.textStyle),
                  ),
                ))
            .toList();
  }

  void _updateTracksList() async {
    await _getTracks();
    _generateTrackListTiles();
  }

  Future<void> _getTracks() async {
    List<Track> newTracks = await ApiService.getTracks();
    setState(() {
      tracks = newTracks;
    });
  }

  Future<void> _onPressed(Track track) async {
    if (audioPlayer.playing) audioPlayer.stop();
    audioPlayer.setAudioSource(
        HlsAudioSource(Uri.parse(ApiService.getTrackStreamUrl(track))));
    audioPlayer.play();
  }
}
