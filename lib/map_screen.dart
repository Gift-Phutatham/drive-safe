import 'dart:async';

import 'package:drive_safe/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api_service.dart';
import 'constants.dart';
import 'location_service.dart';
import 'record_model.dart';
import 'db.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  late GoogleMapController mapController;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _searchController = TextEditingController();
  final LatLng _center = const LatLng(13.7563, 100.5018);
  late Set<Marker> markers = {};
  List searchList = [];
  late List<Record> records = [];
  late Map<ExpwStep, List<Record>> map = {};
  late Future<String> _lastUpdate;
  var formatter = DateFormat.EEEE('th');
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    _lastUpdate = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('dateTime') ?? '';
    });
    DB.instance.initDB().then((value) => fetchData());
    super.initState();
  }

  Future<void> syncDate() async {
    await _getData();
    await _getMarkers();
    await _updateSyncDateTime();
    print('done');
  }

  void fetchData() async {
    List<Map<String, dynamic>> results = await DB.instance.getAllRecords();
    print(results.length);
    setState(() {
      records = results.map((result) => Record.fromJson(result)).toList();
      records = records.where((record) => filterRecord(record)).toList();
    });
    fetchMap();
    await _getMarkers();
  }

  Future<void> _getData() async {
    List<RecordModel?> _record = (await ApiService().getAllRecords())!;

    // Simulate QUERY time for the real API call
    await Future.delayed(const Duration(seconds: 1)).then(
      (value) => setState(
        () {
          records = [];
          for (var year in _record) {
            if (year != null) {
              records.addAll(year.result.records);
            }
          }
          print(records.length);
        },
      ),
    );
    if (records.isNotEmpty) {
      await DB.instance.deleteAllRecords();
    }
    for (var record in records) {
      await DB.instance.insertRecord(record);
    }

    setState(() {
      records = records.where((record) => filterRecord(record)).toList();
      print("How many records?");
      print(records.length);
    });

    fetchMap();
  }

  void fetchMap() {
    setState(() {
      for (var element in records) {
        if (map.containsKey(element.expwStep)) {
          map[element.expwStep]?.add(element);
        } else {
          map[element.expwStep] = [element];
        }
      }
    });
  }

  Future<void> _updateSyncDateTime() async {
    final SharedPreferences prefs = await _prefs;
    final String date = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

    setState(() {
      _lastUpdate = prefs.setString('dateTime', date).then((bool success) {
        return date;
      });
    });
    print(date);
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
          : map[key]!.length >= 5
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
    print('done');
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final String placeName = place['name'];

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 18)));

    showModalBottomSheet(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              ElevatedButton(
                  child: const Text('เส้นทาง'),
                  onPressed: () {
                    Navigator.pop(context);
                    getDirections(lat, lng, placeName);
                  })
            ],
          ),
        );
      },
    );
  }

  void getDirections(double lat, double lng, String placeName) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env["MAPS_API_KEY"]!,
      PointLatLng(_center.latitude, _center.longitude),
      PointLatLng(lat, lng),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);

    mapController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(southwest: _center, northeast: LatLng(lat, lng)), 25));

    showModalBottomSheet(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('$placeName'),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      polylines.clear();
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "แผนที่",
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
                  polylines: Set<Polyline>.of(polylines.values),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 10, 25),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: FutureBuilder<String>(
                        future: _lastUpdate,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const CircularProgressIndicator();
                            default:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Text(
                                  'updated: ${snapshot.data}',
                                );
                              }
                          }
                        }),
                  ),
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
                              ),
                            ),
                            subtitle: Text(
                              searchList[index]['structured_formatting']
                                      ['secondary_text'] ??
                                  '',
                              style: const TextStyle(
                                fontSize: 13,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.sync,
          color: Colors.grey,
          size: 25,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          syncDate();
        },
      ),
    );
  }
}
