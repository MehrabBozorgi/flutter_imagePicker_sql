import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_place_app/db/db_helper.dart';
import 'package:flutter_place_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => _items;

  void addPlace(String pickTitle, File pickImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickTitle,
      image: pickImage,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
