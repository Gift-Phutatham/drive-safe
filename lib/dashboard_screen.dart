import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';
import 'constants.dart';
import 'dashboard_details_screen.dart';
import 'db.dart';
import 'record_model.dart';
import 'statistic_model.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  // Instance variables
  late List<Record> records = [];
  late Map<ExpwStep, List<Record>> map = {};
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _lastUpdate;

  @override
  void initState() {
    _lastUpdate = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('dateTime') ?? '';
    });
    DB.instance.initDB().then((value) => fetchData());
    super.initState();
  }

  void fetchData() async {
    List<Map<String, dynamic>> results = await DB.instance.getAllRecords();
    setState(() {
      records = results.map((result) => Record.fromJson(result)).toList();
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

  void _getData() async {
    List<RecordModel?> _record = (await ApiService().getAllRecords())!;

    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => setState(
        () {
          records.clear();
          map.clear();
          for (var year in _record) {
            if (year != null) {
              records.addAll(year.result.records);
            }
          }
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

  Map<String, double> getCausesMap(Map<String, double> allCauses) {
    Map<String, double> causes = {};
    var sortedMap = Map.fromEntries(allCauses.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));
    causes.addEntries(sortedMap.entries.toList().getRange(0, 3));
    var others = sortedMap.values.toList().getRange(3, sortedMap.length);
    var sum = others.reduce((a, b) => a + b);
    causes['อื่นๆ'] = sum;
    return causes;
  }

  Statistic getStatistic(ExpwStep name) {
    List<Record> thisRecords = map[name]!;
    Map<WeatherState, int> weatherStat = {};
    int totalDead = 0;
    int totalInjured = 0;
    Map<String, double> causes = {};
    for (var weatherState in WeatherState.values) {
      weatherStat[weatherState] = 0;
    }
    for (var element in thisRecords) {
      weatherStat.update(element.weatherState,
          (value) => weatherStat[element.weatherState]! + 1);
      totalDead += element.deadMan;
      totalDead += element.deadFemel;
      totalInjured += element.injurMan;
      totalInjured += element.deadFemel;
      if (causes.containsKey(element.cause)) {
        causes.update(element.cause, (value) => causes[element.cause]! + 1);
      } else {
        causes[element.cause] = 1;
      }
    }

    return Statistic(
      totalAccidents: thisRecords.length,
      weatherStat: weatherStat,
      totalDead: totalDead,
      totalInjured: totalInjured,
      causes: getCausesMap(causes),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "สถิติ",
        ),
        backgroundColor: kMainColor,
      ),
      body: map.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                ListView.separated(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: map.length,
                  itemBuilder: (context, index) {
                    ExpwStep key = map.keys.elementAt(index);
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardDetailsScreen(
                            name: expwStepValues.getValue(key),
                            statistic: getStatistic(key),
                            themeColor: map[key]!.length >= 200
                                ? kRedColor
                                : map[key]!.length >= 50
                                    ? kOrangeColor
                                    : kYellowColor,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: map[key]!.length >= 50
                                ? kRedColor
                                : map[key]!.length >= 20
                                    ? kOrangeColor
                                    : kYellowColor,
                            width: 1,
                          ),
                          color: Colors.white,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'ทางด่วนพิเศษ${expwStepValues.getValue(key)}',
                                      style: TextStyle(
                                        color: map[key]!.length >= 200
                                            ? kRedColor
                                            : map[key]!.length >= 50
                                                ? kOrangeColor
                                                : kYellowColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                      0.0,
                                      20.0,
                                      0.0,
                                      20.0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: map[key]!.length >= 200
                                          ? kRedColor
                                          : map[key]!.length >= 50
                                              ? kOrangeColor
                                              : kYellowColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: const [
                                            Text(
                                              'จำนวนอุบัติเหตุทั้งหมด',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '(2563 - ปัจจุบัน)',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          map[key]!.length.toString(),
                                          style: const TextStyle(
                                            fontSize: 32,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
                FutureBuilder<String>(
                    future: _lastUpdate,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(4.0, 1.0, 0.0, 0.0),
                              child: Text(
                                'updated: ${snapshot.data}',
                              ),
                            );
                          }
                      }
                    }),
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
          _getData();
        },
      ),
    );
  }
}
