import 'package:conditional_wrap/conditional_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Track>? tracks = List<Track>.empty();
  List<Widget> trackTiles = List<Widget>.empty();
  ScrollController controller = ScrollController();
  int currentTrack = 0;
  @override
  void initState() {
    try {
      // _getTracks();
      // _updateTracksList();
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
            child: WidgetWrapper(
                wrapper: (child) => kIsWeb
                    ? WebSmoothScroll(controller: controller, child: child)
                    : child,
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
                        : SliverPadding(
                            padding: const EdgeInsets.only(bottom: 100),
                            sliver: SliverList.list(
                              children: [
                                trackTiles.isEmpty
                                    ? const Text("Список пуст")
                                    : CupertinoListSection.insetGrouped(
                                        topMargin: 0,
                                        children: trackTiles,
                                      ),
                              ],
                            ),
                          ),
                  ],
                )));
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
                    debugPrint(e.$2.fileName);
                  },
                  child: CupertinoListTile(
                    leading: const Icon(CupertinoIcons.music_note_2,
                        color: CupertinoColors.activeOrange),
                    title: Text(e.$2.title ?? ''),
                    subtitle: Text(e.$2.artist ?? ''),
                  ),
                ))
            .toList();
  }

  void _updateTracksList() async {
    await _getTracks();
    _generateTrackListTiles();
  }

  Future<void> _getTracks() async {
    setState(() {});
  }

  Future<void> _onPressed() async {}
}

class Track {
  var title;

  var artist;

  String? fileName;
}
