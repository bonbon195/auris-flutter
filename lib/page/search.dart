import 'package:auris/model/track.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController controller = ScrollController();
  List<Track>? tracks;
  List<Widget> trackTiles = List<Widget>.empty();
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
                  largeTitle: Text("Поиск"),
                ),
                tracks == null
                    ? const SliverFillRemaining(
                        child: Center(
                          child: CupertinoActivityIndicator(
                            animating: true,
                          ),
                        ),
                      )
                    : SliverMainAxisGroup(slivers: [TextFormField()]),
                trackTiles.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text(
                            "Не найдено ни одного трека",
                            style:
                                CupertinoTheme.of(context).textTheme.textStyle,
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.only(bottom: 120),
                        sliver: SliverList.list(
                          children: [
                            CupertinoListSection(
                              topMargin: 0,
                              margin: const EdgeInsets.all(0),
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
}
