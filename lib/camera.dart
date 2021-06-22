import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/app_drawer.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  File _image;

  Future getImage(bool isCamera) async{
    File image;
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }else{
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.insert_drive_file),
              onPressed: () {
                getImage(false);
              },
            ),
            SizedBox(height: 10.0,),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                getImage(true);
              },
            ),
            _image == null? Container() : Image.file(_image, height: 300.0,width: 300.0,),
          ],
        ),
      ),
    );
  }
}
