import 'package:FlutterFYP/providers/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../providers/auth.dart';
import '../providers/repository.dart';
import '../providers/item.dart';

import '../widgets/comments_list.dart';
import '../screens/share_with_patient_screen.dart';
import '../screens/edit_repository_item_screen.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = '/video-screen';

  final hasComments;

  VideoScreen(this.hasComments);

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
        forceHideAnnotation: true,
      ),
    );
    // ..addListener(() {
    //     if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
    //       setState(() {
    //         _playerState = _controller.value.playerState;
    //         _videoMetaData = _controller.metadata;
    //       });
    //     }
    // });

    // _videoMetaData = YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _idController.dispose();
    // _seekToController.dispose();
    super.dispose();
  }

  void _goToShareWithPatientPage(item) {
    Navigator.of(context).pushNamed(
      ShareWithPatientScreen.routeName,
      arguments: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    // final group = Provider.of<Group>(context);
    final item = Provider.of<Item>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        actions: auth.isMDT
            ? <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(
                    EditRepositoryItemScreen.routeName,
                    arguments: item.id,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => _goToShareWithPatientPage(item),
                  color: Theme.of(context).primaryIconTheme.color,
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
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(item.title, textAlign: TextAlign.center,),
              SizedBox(
                height: 10,
              ),
              Text(item.description, textAlign: TextAlign.justify, ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        widget.hasComments ? CommentsList() : Container(),
      ]),
    );
  }
}
