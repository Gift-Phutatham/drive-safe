import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:drive_safe/record_model.dart';

class DashboardDetailsScreen extends StatelessWidget {
  const DashboardDetailsScreen(
      {required this.name, required this.records, required this.weatherStat});
  final String name;
  final List<Record> records;
  final Map<WeatherState, int> weatherStat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          name,
          style: const TextStyle(fontFamily: 'Prompt'),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kBoxColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Text(
                        'จำนวนอุบัติเหตุทั้งหมด',
                        style: TextStyle(
                            fontFamily: 'Prompt', color: Colors.white),
                      ),
                      Text(
                        '(2563 - ปัจจุบัน)',
                        style: TextStyle(
                            fontFamily: 'Prompt', color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    records.length.toString(),
                    style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Prompt',
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kBoxColor,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'สภาพอากาศ',
                      style: const TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.white,
                          ),
                          Text(
                            'ปกติ',
                            style: TextStyle(
                                fontFamily: 'Prompt', color: Colors.white),
                          ),
                          Text(
                            weatherStat[WeatherState.EMPTY].toString(),
                            style: TextStyle(
                                fontFamily: 'Prompt', color: Colors.white),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.thunderstorm,
                            color: Colors.white,
                          ),
                          Text(
                            'ฝนตก',
                            style: TextStyle(
                                fontFamily: 'Prompt', color: Colors.white),
                          ),
                          Text(
                              weatherStat[WeatherState.WEATHER_STATE]
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: 'Prompt', color: Colors.white))
                        ],
                      ),
                    ],
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
