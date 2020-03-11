import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  static const pageRoute = '/profile';
String nam;
String te;
String emai;
 
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  @override
  Widget build(BuildContext context) {
    File _pickedImage;
    Future<void> _takePick() async {
      final imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
      if (imageFile == null) {
        return;
      }
      setState(() {
        _pickedImage = imageFile;
      });
    }

    final user = Provider.of<Auth>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.edit), onPressed: () {})
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              child: _pickedImage != null
                  ? Image.file(_pickedImage)
                  : Icon(Icons.device_unknown),
            ),
            FlatButton(onPressed: _takePick, child: Text('prendre une photo')),
            ListTile(
              trailing: Text('Nom'),
              title: Text('Marwen'),
            ),
            ListTile(
              trailing: Text('Tel'),
              title: Text( '+216 50453517'),
            ),
            ListTile(
              trailing: Text('e-Mail'),
              title: Text('marwanbk2000@gmail.com'),
            ),
            FlatButton(
                onPressed: () {
                  Provider.of<Auth>(context).logout();
                },
                child: Text('Log Out'))
          ],
        ));
  }
}
