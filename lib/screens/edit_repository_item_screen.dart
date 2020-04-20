import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';
import '../providers/repository.dart';
import '../widgets/app_drawer.dart';

class EditRepositoryItemScreen extends StatefulWidget {
  static const routeName = '/edit-repository-item-screen';
  @override
  _EditRepositoryItemScreenState createState() =>
      _EditRepositoryItemScreenState();
}

class _EditRepositoryItemScreenState extends State<EditRepositoryItemScreen> {
  final _form = GlobalKey<FormState>();
  final _mediaFocusNode = FocusNode();
  final _categoryFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _linkUrlController = TextEditingController();
  final _imageUrlController = TextEditingController();

  var _isInit = true;
  var _isLoading = false;
  Map<String, dynamic> _initValues = {
    'title': '',
    'media': '',
    'category': '',
    'description': '',
    'linkUrl': '',
    'imageUrl': '',
  };
  var _editedItem = Item(
    id: null,
    title: '',
    media: '',
    category: '',
    description: '',
    linkUrl: '',
    imageUrl: '',
  );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final itemId = ModalRoute.of(context).settings.arguments as int;
      if (itemId != null) {
        print('item id is not null');
        _editedItem =
            Provider.of<Repository>(context, listen: false).findById(itemId);
        _initValues = {
          'title': _editedItem.title,
          'media': _editedItem.media,
          'category': _editedItem.category,
          'description': _editedItem.description,
        };
      }
        _linkUrlController.text = _editedItem.linkUrl;
        _imageUrlController.text = _editedItem.imageUrl;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _mediaFocusNode.dispose();
    _categoryFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _linkUrlController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isFormValid = _form.currentState.validate();
    if (!isFormValid) return;
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedItem.id != null) {
      try {
        await Provider.of<Repository>(context, listen: false)
          .updateRepoItem(_editedItem);
      } catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error Occurred!'),
            content: Text('Something went wrong while editing post.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    } 
    else {
      try {
        await Provider.of<Repository>(context, listen: false)
          .addRepoItem(_editedItem);
      } catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error Occurred!'),
            content: Text('Something went wrong while creating post.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
    setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Repo Item'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      // drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                        initialValue: _initValues['title'],
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_mediaFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // _savedValues['title'] = value;
                          _editedItem = Item(
                            id: _editedItem.id,
                            media: _editedItem.media,
                            category: _editedItem.category,
                            title: value,
                            description: _editedItem.description,
                            linkUrl: _editedItem.linkUrl,
                            imageUrl: _editedItem.imageUrl,
                          );
                        }),
                    TextFormField(
                        focusNode: _mediaFocusNode,
                        initialValue: _initValues['media'],
                        decoration: InputDecoration(
                          labelText: 'Media',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_categoryFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter type of media [text, audio, video]';
                          }
                          var validMedia = ['video', 'text'];
                          if (!validMedia.contains(value))
                          // if (value.compareTo('video') != 0)
                          // ||
                          //     value.compareTo('audio') != 0 ||
                          //     value.compareTo('text') != 0)
                          {
                            return 'Please enter type of media : text, audio, or video';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // _savedValues['media'] = value.trim();
                          _editedItem = Item(
                            id: _editedItem.id,
                            media: value,
                            category: _editedItem.category,
                            title: _editedItem.title,
                            description: _editedItem.description,
                            linkUrl: _editedItem.linkUrl,
                            imageUrl: _editedItem.imageUrl,
                          );
                        }),
                    TextFormField(
                        focusNode: _categoryFocusNode,
                        initialValue: _initValues['category'],
                        decoration: InputDecoration(
                          labelText: 'Category',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a category.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // _savedValues['category'] = value;
                          _editedItem = Item(
                            id: _editedItem.id,
                            media: _editedItem.media,
                            category: value,
                            title: _editedItem.title,
                            description: _editedItem.description,
                            linkUrl: _editedItem.linkUrl,
                            imageUrl: _editedItem.imageUrl,
                          );
                        }),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      focusNode: _descriptionFocusNode,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description';
                        }
                      },
                      onSaved: (value) {
                        // _savedValues['description'] = value;
                        _editedItem = Item(
                          id: _editedItem.id,
                          media: _editedItem.media,
                          category: _editedItem.category,
                          title: _editedItem.title,
                          description: value,
                          linkUrl: _editedItem.linkUrl,
                          imageUrl: _editedItem.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      // initialValue: _initValues['linkUrl'],
                      decoration: InputDecoration(
                        labelText: 'Link URL',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      // focusNode: ,
                      controller: _linkUrlController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a url.';
                        }
                        // if (!value.startsWith('http') &&
                        //     !value.startsWith('https')) {
                        //   return 'Please enter a valid url.';
                        // }
                        // if (!value.endsWith('.png') &&
                        //     !value.endsWith('.jpg') &&
                        //     !value.endsWith('.jpeg')) {
                        //   return 'Please enter a valid url';
                        // }
                        return null;
                      },
                      onSaved: (value) {
                        // _savedValues['linkUrl'] = value;
                        _editedItem = Item(
                          id: _editedItem.id,
                          media: _editedItem.media,
                          category: _editedItem.category,
                          title: _editedItem.title,
                          description: _editedItem.description,
                          linkUrl: value,
                          imageUrl: _editedItem.imageUrl,
                        );
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                    TextFormField(
                      // initialValue: _initValues['imageUrl'],
                      controller: _imageUrlController,
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      // focusNode: ,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a url.';
                        }
                        // if (!value.startsWith('http') &&
                        //     !value.startsWith('https')) {
                        //   return 'Please enter a valid url.';
                        // }
                        // if (!value.endsWith('.png') &&
                        //     !value.endsWith('.jpg') &&
                        //     !value.endsWith('.jpeg')) {
                        //   return 'Please enter a valid url';
                        // }
                        return null;
                      },
                      onSaved: (value) {
                        // _savedValues['imageUrl'] = value;
                        _editedItem = Item(
                          id: _editedItem.id,
                          media: _editedItem.media,
                          category: _editedItem.category,
                          title: _editedItem.title,
                          description: _editedItem.description,
                          linkUrl: _editedItem.linkUrl,
                          imageUrl: value,
                        );
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
