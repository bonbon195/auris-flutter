import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class ExpandablePlayer extends StatefulWidget {
  // final Widget? child;
  // final Function(double) setInset;
  const ExpandablePlayer({super.key});
  // const ExpandablePlayer({super.key, required this.setInset});

  @override
  State<ExpandablePlayer> createState() => _ExpandablePlayerState();
}

class _ExpandablePlayerState extends State<ExpandablePlayer> {
  @override
  void initState() {
    super.initState();
  }

//   @override
//   Widget build(BuildContext context) {
//     return SlidingUpPanelWidget(
//       upperBound: 0,
//       minimumBound: -1,
//       child: Container(
//         color: CupertinoColors.white,
//         margin: EdgeInsets.only(bottom: 100),
//       ),
//       // child: ClipRect(
//       //     child: BackdropFilter(
//       //   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//       //   child: Container(
//       //     color: CupertinoColors.secondarySystemFill,
//       //   ),
//       // )),
//       controlHeight: 100,
//       panelController: panelController,
//       enableOnTap: true,
//       onTap: () {},
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      onPanelSlide: (position) {},
      onPanelClosed: () {
        // widget.setInset(defaultTargetPlatform == TargetPlatform.iOS ? 70 : 50);
      },
      onPanelOpened: () {
        // widget.setInset(0);
      },

      color: CupertinoColors.secondarySystemFill,
      boxShadow: const [],
      minHeight: 70,
      maxHeight: MediaQuery.of(context).size.height,
      collapsed: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Image.network(
                    '${const String.fromEnvironment('API_URL')}/api/files/n7bud6ny21sai6o/7fty33til0alhkh/artwork_CkYb2GaqRX.jpg'), // for testing purposes
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: CupertinoTheme.of(context).textTheme.textStyle
                        ..copyWith(fontSize: 14),
                    ),
                    Text(
                      "Author",
                      style: CupertinoTheme.of(context).textTheme.textStyle
                        ..copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      minSize: 0,
                      child: const Icon(
                        CupertinoIcons.play_fill,
                      ),
                      onPressed: () {}),
                ),
              ),
            ],
          )),
      panel: ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: CupertinoColors.secondarySystemFill,
              ))),
      // panel: Container(
      //   color: CupertinoColors.secondarySystemFill,
      //   child: ClipRRect(
      //     child: BackdropFilter(
      //         filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
      //         child: CupertinoButton(
      //           child: Text("asdas"),
      //           onPressed: _onClick,
      //         )),
      //   ),
    );
  }

  void _onClick() {
    setState(() {});
  }
}
