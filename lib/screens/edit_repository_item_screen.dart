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
  var _isLoading = false;
  var _initValues = {
    'title': '',
    'description': '',
    'media': '',
    'category': '',
    'linkUrl': '',
    'imageUrl': '',
  };
  var _savedValues = {
    'title': '',
    'description': '',
    'media': '',
    'category': '',
    'linkUrl': '',
    'imageUrl': '',
  };
  var _editedItem = Item(
    // id: null,
    title: '',
    description: '',
    media: '',
    category: '',
    link_url: '',
    image_url: '',
  );

  @override
  void dispose() {
    _mediaFocusNode.dispose();
    _categoryFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  _saveForm() {
    final isFormValid = _form.currentState.validate();
    if (!isFormValid) return;
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print(
      "savedValues: " +
          _savedValues['title'] +
          _savedValues['media'] +
          _savedValues['category'] +
          _savedValues['description'] +
          _savedValues['url'],
    );
    Item _newItem = Item(
      title: _savedValues['title'],
      description: _savedValues['description'],
      media: _savedValues['media'],
      category: _savedValues['category'],
      link_url: _savedValues['url'],
      image_url: _savedValues['url'],
    );

    Provider.of<Repository>(context).editRepoItem(_newItem);
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
      drawer: AppDrawer(),
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
                            FocusScope.of(context)
                                .requestFocus(_mediaFocusNode);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _savedValues['title'] = value;
                            _editedItem = Item(
                              // id: _editedItem.id,
                              media: _editedItem.media,
                              category: _editedItem.category,
                              title: value,
                              description: _editedItem.description,
                              link_url: _editedItem.link_url,
                              image_url: _editedItem.image_url,
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
                            var validMedia = ['video','text'];
                            if(!validMedia.contains(value))
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
                            _savedValues['media'] = value.trim();
                            _editedItem = Item(
                              // id: _editedItem.id,
                              media: value,
                              category: _editedItem.category,
                              title: _editedItem.title,
                              description: _editedItem.description,
                              link_url: _editedItem.link_url,
                              image_url: _editedItem.image_url,
                            );
                          }),
                      TextFormField(
                          focusNode: _categoryFocusNode,
                          initialValue: _initValues['Category'],
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
                            _savedValues['category'] = value;
                            _editedItem = Item(
                              id: _editedItem.id,
                              media: _editedItem.media,
                              category: value,
                              title: _editedItem.title,
                              description: _editedItem.description,
                              link_url: _editedItem.link_url,
                              image_url: _editedItem.image_url,
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
                          _savedValues['description'] = value;
                          _editedItem = Item(
                            id: _editedItem.id,
                            media: _editedItem.media,
                            category: _editedItem.category,
                            title: _editedItem.title,
                            description: value,
                            link_url: _editedItem.link_url,
                            image_url: _editedItem.image_url,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['url'],
                        decoration: InputDecoration(
                          labelText: 'URL',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        // focusNode: ,
                        // controller: _urlController,
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
                          _savedValues['url'] = value;
                          _editedItem = Item(
                            id: _editedItem.id,
                            media: _editedItem.media,
                            category: _editedItem.category,
                            title: _editedItem.title,
                            description: _editedItem.description,
                            // linkUrl: _editedItem.linkUrl,
                            // imageUrl: _editedItem.imageUrl,
                            link_url: value,
                            image_url: value,
                          );
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ],
                  )),
            ),
    );
  }
}
