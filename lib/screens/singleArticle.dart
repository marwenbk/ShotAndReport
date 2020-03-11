import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../provider/articles.dart';
import '../provider/article.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SingleItem extends StatefulWidget {
  static const pageRoute = '/singleItem';
  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  final _titleController = TextEditingController();
  final _adressController = TextEditingController();
  Cat _catController;
  final _descriptionController = TextEditingController();

  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  File _storedImage;
  Future<void> _takePick() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
  }

  bool yes = false;

  LatLng _getCurrentUserLocation() {
    Location().getLocation().then((onValue) {
      setState(() {
        yes = true;
      });
      return onValue;
    }).catchError((o){
      setState(() {
        yes = false;
      });
    });
  }

  void savePlace() {
    
    Provider.of<Articles>(context, listen: false).addArticle(
      _adressController.text,
      _catController,
      _descriptionController.text,
      _titleController.text,
      _getCurrentUserLocation(),
      _storedImage,
    );
    Navigator.of(context).pop();
  }

  Cat _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('add Product')),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: _storedImage != null
                      ? Image.file(
                          _storedImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Text(
                          'No Image Taken',
                          textAlign: TextAlign.center,
                        ),
                  alignment: Alignment.center,
                ),
                Container(
                  child: FlatButton.icon(
                    icon: Icon(Icons.camera),
                    label: Text('Take Picture'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _takePick,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'village'),
                  controller: _adressController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'description'),
                  controller: _descriptionController,
                ),
                DropdownButton<Cat>(
                  value: _selectedLocation,
                  items: <Cat>[
                    Cat.Road,
                    Cat.Light,
                    Cat.Water,
                    Cat.PhoneNetwork,
                    Cat.PublicPropriety,
                    Cat.CorruptionAdministrative,
                    Cat.VenteConditionnelle,
                    Cat.Contrebande,
                    Cat.Monopole,
                    Cat.Corruption,
                    Cat.DroitsHumains,
                    Cat.DroitsAnimaux
                  ].map((Cat value) {
                    return new DropdownMenuItem<Cat>(
                      value: value,
                      child: new Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (ne) {
                    setState(() {
                      _selectedLocation = ne;
                      _catController = ne;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton.icon(
                        icon: Icon(
                          Icons.location_on,
                        ),
                        label: Text('Current Location'),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _getCurrentUserLocation),
                    yes
                        ? Icon(
                            Icons.done,
                            color: Colors.green,
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton.icon(
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.done_outline),
                  onPressed: savePlace,
                  label: Text('Save'),
                ),
              ],
            ),
          ),
        ));
  }
}
