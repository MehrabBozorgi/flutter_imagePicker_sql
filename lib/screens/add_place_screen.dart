import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_place_app/provider/great_places.dart';
import 'package:flutter_place_app/widget/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routName = 'add_place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleTextController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleTextController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleTextController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleTextController,
                    ),
                    SizedBox(height: 15),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            child: Text('Add Place'),
            onPressed: _savePlace,
          ),
        ],
      ),
    );
  }
}
