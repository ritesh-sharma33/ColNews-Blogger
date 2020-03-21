import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class BlogImageUpload extends StatefulWidget {
  @override
  _BlogImageUploadState createState() => _BlogImageUploadState();
}

class _BlogImageUploadState extends State<BlogImageUpload> {

  File file;
  String fileName = '';
  bool isUploaded = false;
  String downloadUrl = '';

  Future<void> _uploadFile(File file, String filename) async {
    StorageReference storageReference;
    storageReference = FirebaseStorage.instance.ref().child('blog_images/$filename');
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    setState(() {
      isUploaded = true;
      this.downloadUrl = url;
    });
    print('URL is $url');
  }

  Future filePicker() async {
    try {
      file = await FilePicker.getFile(type: FileType.image);
      setState(() {
        fileName = p.basename(file.path);
      });
      _uploadFile(file, fileName);
    } on PlatformException catch(e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sorry...'),
            content: Text('Unsupported exception: $e'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            this.isUploaded == true
              ? Image.network(this.downloadUrl, height: deviceHeight * 0.6,)
              : SizedBox(height: 5,),
            RaisedButton(
              child: Text('Select Image'),
              onPressed: filePicker,
            )
          ],
        ),
      ),
    );
  }
}