import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shareskill/screens/category_input_screen.dart';

class ProfilePhotoScreen extends StatelessWidget {
  const ProfilePhotoScreen({Key key}) : super(key: key);
  static const routeName = '/profile-photo-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo,
                  Colors.amberAccent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
              ),
            ),
          ),
          Container(
            child: Center(
              child: SavePicture(),
            ),
          ),
        ],
      ),
    );
  }
}

class SavePicture extends StatefulWidget {
  @override
  _SavePictureState createState() => _SavePictureState();
}

class _SavePictureState extends State<SavePicture> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      // maxHeight: 400,
    );
    setState(() {
      _storedImage = imageFile;
    });
    Navigator.of(context).pop();
  }

  Future<void> _pickPicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
      // maxHeight: 400,
    );
    setState(() {
      _storedImage = imageFile;
    });
    Navigator.of(context).pop();
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            title: Text('Use image from '),
            // content: Text('data'),
            actions: <Widget>[
              FlatButton.icon(
                onPressed: _takePicture,
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              FlatButton.icon(
                onPressed: _pickPicture,
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mdData = MediaQuery.of(context).size;
    return Container(
      child: Card(
        elevation: 8,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: mdData.height * 0.55,
          width: mdData.width * 0.8,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: _storedImage != null
                      ? Image.file(_storedImage, fit: BoxFit.cover)
                      : Icon(Icons.camera),
                ),
                FlatButton.icon(
                  onPressed: _showDialog,
                  icon: Icon(Icons.camera),
                  label: Text('Take Picture'),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Back'),
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(CategoryInputScreen.routeName);
                      },
                      child: Text('Continue'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
