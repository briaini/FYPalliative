import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../providers/auth.dart';
import '../providers/patients.dart';
import '../providers/item.dart';
import '../providers/group.dart';
import '../providers/repository.dart';

import '../widgets/comments_list.dart';
import '../screens/share_with_patient_screen.dart';
import '../screens/edit_repository_item_screen.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = '/video-screen';

  var groupId;
  final item;
  //hasComments: display comments and visibility iconbutton
  final hasComments;

  //from DetailedRepoItemScreen
  // VideoScreen(hasComments) with group provider available
  VideoScreen(this. item, this.hasComments, [this.groupId]);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;
  // YoutubeMetaData _videoMetaData;
  // var _isPlayerReady = false;
  // PlayerState _playerState;

  var _isLoading;

  Future<void> swapPostVisibility(itemId) async {
    // setState(() {
    //   _isLoading = true;
    // });
    print("swapping $itemId and ${Provider.of<Group>(context).id}");
    try {
      await Provider.of<Patients>(context)
          .mdtSwapGroupPostVisibility(itemId, Provider.of<Group>(context));
      await Provider.of<Patients>(context).fetchMyGroups();


      // .then((_) => setState(() {
      // _isLoading = false;
      // Navigator.of(context).pop();
      // }));
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.item.videoId,
      // Provider.of<Item>(context, listen: false).linkUrl,
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
    final group = widget.hasComments ? Provider.of<Group>(context) : null;
    // final item = Provider.of<Item>(context);
    final repoProvider = Provider.of<Repository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        actions: auth.isMDT || auth.isAdmin
            ? <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(
                    EditRepositoryItemScreen.routeName,
                    arguments: widget.item.id,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: widget.groupId == null
                      ? () => _goToShareWithPatientPage(widget.item)
                      : () {
                          showDialog(
                            //returning showDialog returns Future for us
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Are you sure?'),
                              content: Text(
                                  'Do you want to share post(${widget.item.id}) with group: :${widget.groupId}?'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(ctx).pop(false);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    Provider.of<Patients>(context)
                                        .linkPostToGroup(
                                            widget.groupId, widget.item.id);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                widget.hasComments
                    ? IconButton(
                        icon: Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                        onPressed: () {
                          swapPostVisibility(widget.item.id);
                          Navigator.of(context).pop();
                        })
                    //  setState(() {
                    //       Provider.of<Patients>(context)
                    //           .mdtSwapGroupPostVisibility(item.id, group);
                    //       Provider.of<Patients>(context)
                    //           .fetchMyGroups()
                    //           .then(
                    //         (_) {
                    //           setState(() {});
                    //         },
                    //       );
                    //     }))
                    : Container(),
              ]
            : <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.visibility_off,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  onPressed: () =>
                      Provider.of<Patients>(context).hidePostFromGroup(widget.item.id),
                ),
              ],
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
              Text(
                widget.item.title,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.item.description,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        widget.hasComments ? CommentsList(widget.item.id) : Container(),
      ]),
    );
  }
}
