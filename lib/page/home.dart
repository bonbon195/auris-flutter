import 'package:auris/components/expandable_player.dart';
import 'package:auris/page/favorites.dart';
import 'package:auris/page/playlists.dart';
import 'package:auris/page/search.dart';
import 'package:auris/page/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _inset = defaultTargetPlatform == TargetPlatform.iOS ? 70 : 50;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
                border: const Border(
                    top: BorderSide(color: CupertinoColors.opaqueSeparator),
                    bottom: BorderSide(
                        color: Color.fromARGB(0, 0, 0, 0), width: 20.0)),
                height: defaultTargetPlatform == TargetPlatform.iOS ? 70 : 50,

                // inactiveColor: CupertinoColors.secondarySystemFill,
                backgroundColor: CupertinoColors.secondarySystemFill,
                items: const [
                  BottomNavigationBarItem(
                      label: "Поиск", icon: Icon(CupertinoIcons.search)),
                  BottomNavigationBarItem(
                      label: "Избранное",
                      icon: Icon(CupertinoIcons.square_favorites_alt_fill)),
                  BottomNavigationBarItem(
                      label: "Плейлисты",
                      icon: Icon(CupertinoIcons.music_albums)),
                  BottomNavigationBarItem(
                      label: "Вся музыка", icon: Icon(CupertinoIcons.settings)),
                ]),
            tabBuilder: (context, index) {
              return _buildTab(index);
              // return Padding(
              //     padding: const EdgeInsets.only(bottom: 100),
              //     child: _buildTab(index));
              // return SafeArea(child: _buildTab(index));
              // return Positioned.fill(bottom: 100, child: _buildTab(index));
            }),
        Positioned.fill(
            bottom: _inset,
            child: ExpandablePlayer(
              setInset: setInset,
            )),
      ],
    );
  }

  void setInset(double inset) {
    setState(() {
      _inset = inset;
    });
  }

  Widget _buildTab(int index) {
    switch (index) {
      case 0:
        return const SearchPage();
      case 1:
        return const FavoritesPage();
      case 2:
        return const PlaylistsPage();
      case 3:
        return const SettingsPage();
      default:
        throw Exception("No such tab index: $index");
    }
  }
}
