import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comment.dart';
import '../providers/patient.dart';
import '../providers/repository.dart';
import '../widgets/repository_list.dart';
import '../widgets/repository_item.dart';


class MdtPatientSharedRepo extends StatefulWidget {
  // final patientId;

  // MdtPatientRepo(this.patientId);

  @override
  _MdtPatientSharedRepoState createState() => _MdtPatientSharedRepoState();
}

class _MdtPatientSharedRepoState extends State<MdtPatientSharedRepo> {
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(
  //       () {
  //         _isLoading = true;
  //       },
  //     );
  //     Provider.of<Patient>(context).fetchComments().then(
  //       (_) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       },
  //     );
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<Patient>(context);
    final repo = Provider.of<Repository>(context);

    final posts = repo.items.where((element) => patient.posts.contains(element.id));
    List<Comment> comments = patient.comments;

    comments.forEach((comment) {
      posts.forEach((post) {
          if(comment.postId == post.id) {
            post.addComment(comment);
            print('match');
          }
       });
    });

    return Container(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: posts.length,
          itemBuilder: (_, i) => ChangeNotifierProvider.value(
              value: posts.elementAt(i), 
              child: RepositoryItem()),
          separatorBuilder: (_, i) => const Divider(),
        ),
      );
  }
}
