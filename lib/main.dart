import 'package:flutter/material.dart';
import 'package:flutter_place_app/provider/great_places.dart';
import 'package:flutter_place_app/screens/add_place_screen.dart';
import 'package:flutter_place_app/screens/place_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PlacesListScreen(),
        routes: {

          'add_place' :(context)=>AddPlaceScreen(),

        },
      ),
    );
  }
}
