import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'constants.dart';
import 'favorite_screen.dart';
import 'location_service.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;
  TextEditingController _searchController = TextEditingController();

  final LatLng _center = const LatLng(13.7563, 100.5018);

  final Set<Marker> markers = {};
  static const LatLng showLocation = LatLng(13.7563, 100.5018);
  List searchList = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Marker Title First ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }

  Future<void> goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = mapController;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 18)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "แผนที่",
            style: TextStyle(fontFamily: 'Prompt'),
          ),
          backgroundColor: kBackgroundColor,
        ),
        body: Column(
          children: [
            Container(
              height: 70,
              decoration: const BoxDecoration(
                color: kBackgroundColor,
              ),
              alignment: Alignment.center,
              child: Container(
                width: 380,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: kBackgroundColor,
                    width: 1,
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          var placeId = await LocationService()
                              .getPlaceId(_searchController.text);
                          var place = await LocationService().getPlace(placeId);
                          goToPlace(place);
                        },
                        icon: Icon(Icons.search)),
                    Expanded(
                      child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'ค้นหา',
                            hintStyle: TextStyle(fontFamily: ('Prompt')),
                          ),
                          controller: _searchController,
                          onChanged: (value) async {
                            List newList =
                                await LocationService().getAutocomplete(value);
                            setState(() {
                              if (newList.length > 4) {
                                searchList = newList.getRange(0, 4).toList();
                              } else {
                                searchList = newList;
                              }
                              print(searchList);
                              print(searchList.length);
                            });
                            // print(LocationService().getAutocomplete(value));
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    markers: getmarkers(),
                  ),
                  if (searchList.isNotEmpty)
                    ListView.builder(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            var place = await LocationService()
                                .getPlace(searchList[index]['place_id']);
                            _searchController.clear();
                            setState(() {
                              searchList = [];
                            });
                            await goToPlace(place);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: index == 0
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    )
                                  : index == (searchList.length - 1)
                                      ? BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        )
                                      : BorderRadius.zero,
                              color: Colors.white,
                            ),
                            child: ListTile(
                              title: Text(
                                searchList[index]['structured_formatting']
                                    ['main_text'],
                                style: kTextStyleSearch,
                              ),
                              subtitle: Text(
                                searchList[index]['structured_formatting']
                                        ['secondary_text'] ??
                                    '',
                                style: kTextStyleSearch,
                              ),
                              trailing: Icon(Icons.favorite),
                            ),
                          ),
                        );
                      },
                    ),
                  // Container(
                  //   height: 100,
                  //   color: Colors.black,
                  // ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FavoriteScreen(),
            ),
          ),
          backgroundColor: kBackgroundColor,
          child: const Icon(
            Icons.favorite,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
