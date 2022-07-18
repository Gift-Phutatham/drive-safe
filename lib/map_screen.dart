import 'package:drive_safe/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'api_service.dart';
import 'constants.dart';
import 'location_service.dart';
import 'record_model.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;
  final TextEditingController _searchController = TextEditingController();

  final LatLng _center = const LatLng(13.7563, 100.5018);

  late Set<Marker> markers = {};
  static const LatLng showLocation = LatLng(13.7563, 100.5018);
  List searchList = [];

  late List<Record> records = [];
  late Map<ExpwStep, List<Record>> map = {};
  var formatter = DateFormat.EEEE('th');

  @override
  void initState() {
    super.initState();
    initFunc();
  }

  void initFunc() async {
    await _getData();
    await _getMarkers();
  }

  Future<void> _getData() async {
    List<RecordModel?> _record = (await ApiService().getAllRecords())!;

    // Simulate QUERY time for the real API call
    await Future.delayed(const Duration(seconds: 1)).then(
      (value) => setState(
        () {
          for (var year in _record) {
            if (year != null) {
              records.addAll(year.result.records);
            }
          }

          records = records.where((record) => filterRecord(record)).toList();
          print("How many records?");
          print(records.length);

          for (var element in records) {
            if (map.containsKey(element.expwStep)) {
              map[element.expwStep]?.add(element);
            } else {
              map[element.expwStep] = [element];
            }
          }
        },
      ),
    );
  }

  bool filterRecord(Record record) {
    DateTime today = DateTime.now();
    List s = record.accidentTime.split(':');
    int hour = int.parse(s[0]);
    return record.accidentDate.weekday == today.weekday && today.hour == hour;
  }

  Future<void> _getMarkers() async {
    Set<Marker> newMarker = {};
    for (ExpwStep key in map.keys) {
      String placeName = expwStepValues.getValue(key);
      String placeId = await LocationService().getPlaceId('ทางพิเศษ$placeName');
      var place = await LocationService().getPlace(placeId);
      final double lat = place['geometry']['location']['lat'];
      final double lng = place['geometry']['location']['lng'];

      DateTime today = DateTime.now();
      Color dialogColor = map[key]!.length >= 10
          ? kRedColor
          : map[key]!.length >= 3
              ? kOrangeColor
              : kYellowColor;

      setState(
        () {
          newMarker.add(
            Marker(
              markerId: MarkerId(placeName),
              position: LatLng(lat, lng),
              icon: BitmapDescriptor.defaultMarker,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Container(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          color: dialogColor,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'ทางด่่วน$placeName',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'สถิติจำนวนอุบัติเหตุ (2562-2565)',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      titlePadding:
                          const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      contentPadding:
                          const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      content: Container(
                        constraints: const BoxConstraints(maxHeight: 100),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  formatter.format(today),
                                  style: TextStyle(
                                    color: dialogColor,
                                  ),
                                ),
                                Text(
                                  '${today.hour}:00 - ${today.hour + 1}:00',
                                  style: TextStyle(
                                    color: dialogColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              map[key]!.length.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                color: dialogColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(dialogColor),
                          ),
                          child: const Text(
                            'ปิด',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      actionsAlignment: MainAxisAlignment.center,
                    );
                  },
                );
              },
            ),
          );
        },
      );
    }

    setState(() {
      markers = newMarker;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 18)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "แผนที่",
            style: TextStyle(fontFamily: kFontFamily),
          ),
          backgroundColor: kMainColor,
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.white,
                iconSize: 30,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoriteScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 70,
              decoration: const BoxDecoration(
                color: kMainColor,
              ),
              alignment: Alignment.center,
              child: Container(
                width: 380,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: kMainColor,
                    width: 1,
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        var placeId = await LocationService()
                            .getPlaceId(_searchController.text);
                        var place = await LocationService().getPlace(placeId);
                        _searchController.clear();
                        setState(() {
                          searchList = [];
                        });
                        await goToPlace(place);
                      },
                      icon: const Icon(Icons.search),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'ค้นหา',
                          hintStyle: TextStyle(fontFamily: kFontFamily),
                        ),
                        controller: _searchController,
                        onChanged: (value) async {
                          List newList =
                              await LocationService().getAutocomplete(value);
                          setState(
                            () {
                              if (newList.length > 4) {
                                searchList = newList.getRange(0, 4).toList();
                              } else {
                                searchList = newList;
                              }
                              print(searchList);
                              print(searchList.length);
                            },
                          );
                          // print(LocationService().getAutocomplete(value));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    markers: markers,
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
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    )
                                  : index == (searchList.length - 1)
                                      ? const BorderRadius.only(
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
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: kFontFamily,
                                ),
                              ),
                              subtitle: Text(
                                searchList[index]['structured_formatting']
                                        ['secondary_text'] ??
                                    '',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: kFontFamily,
                                ),
                              ),
                              trailing: const Icon(Icons.favorite),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
