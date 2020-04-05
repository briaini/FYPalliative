import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../providers/auth.dart';
import '../widgets/comments_list.dart';
import '../screens/share_with_patient_screen.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = '/video-screen';
  final item;

  VideoScreen(this.item);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;
  // YoutubeMetaData _videoMetaData;
  // var _isPlayerReady = false;
  // PlayerState _playerState;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'T6FEuBFckp8',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        // forceHideAnnotation: true,
      ),
    );
    // ..addListener(() {
    //     if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
    //       setState(() {
    //         _playerState = _controller.value.playerState;
    //         _videoMetaData = _controller.metadata;
    //       });
    //     }
    //   });

    // _videoMetaData = YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  }

  // @override
  // void deactivate() {
  //   // Pauses video while navigating to next page.
  //   _controller.pause();
  //   super.deactivate();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   // _idController.dispose();
  //   // _seekToController.dispose();
  //   super.dispose();
  // }

  void _goToShareWithPatientPage() {
    Navigator.of(context).pushNamed(
      ShareWithPatientScreen.routename,
      arguments: widget.item.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        actions: auth.isMDT
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: _goToShareWithPatientPage,
                )
              ]
            : null,
      ),
      body: Column(children: <Widget>[
        YoutubePlayer(
          key: ObjectKey(_controller),
          controller: _controller,
          showVideoProgressIndicator: true,
          // progressIndicatorColor: Colors.amber,
          //  progressColors: ProgressColors(
          //     playedColor: Colors.amber,
          //     handleColor: Colors.amberAccent,
          //  ),
          // onReady: () {
          //   print('Player is ready.');
          //   _isPlayerReady = true;
          // },
          // actionsPadding: EdgeInsets.only(left: 16.0),
          bottomActions: [
            CurrentPosition(),
            SizedBox(width: 10.0),
            ProgressBar(isExpanded: true),
            SizedBox(width: 10.0),
            RemainingDuration(),
            FullScreenButton(),
          ],
        ),
        CommentsList(widget.item),
      ]),
    );
  }
}
