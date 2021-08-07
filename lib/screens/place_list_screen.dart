import 'package:flutter/material.dart';
import 'package:flutter_place_app/db/db_helper.dart';
import 'package:flutter_place_app/provider/great_places.dart';
import 'package:flutter_place_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatefulWidget {
  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('No place add'),
                ),
                builder: (context, greatPlace, child) =>
                    greatPlace.items.length <= 0
                        ? child!
                        : ListView.builder(
                            itemCount: greatPlace.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlace.items[index].image),
                              ),
                              title: Text(greatPlace.items[index].title),
                              onTap: () {
                                setState(() {
                                  DBHelper.delete(greatPlace.items[index].id);
                                  print('object');
                                });
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
