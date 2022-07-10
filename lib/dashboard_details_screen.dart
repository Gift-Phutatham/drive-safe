import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:drive_safe/record_model.dart';
import 'package:drive_safe/statistic_model.dart';

class DashboardDetailsScreen extends StatelessWidget {
  const DashboardDetailsScreen({required this.name, required this.statistic});
  final String name;
  final Statistic statistic;

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
                border: Border.all(color: kBoxColor, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Text(
                        'จำนวนอุบัติเหตุทั้งหมด',
                        style:
                            TextStyle(fontFamily: 'Prompt', color: kTextColor),
                      ),
                      Text(
                        '(2563 - ปัจจุบัน)',
                        style:
                            TextStyle(fontFamily: 'Prompt', color: kTextColor),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kBoxColor,
                    ),
                    child: Text(
                      statistic.totalAccidents.toString(),
                      style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Prompt',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBoxColor, width: 1),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: kBoxColor,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'จำนวนอุบัติเหตุตามสภาพอากาศ',
                        style: const TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.sunny,
                              color: kTextColor,
                            ),
                            Text(
                              'ปกติ',
                              style: TextStyle(
                                  fontFamily: 'Prompt', color: kTextColor),
                            ),
                            Text(
                              statistic.weatherStat[WeatherState.EMPTY]
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: 'Prompt', color: kTextColor),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.thunderstorm,
                              color: kTextColor,
                            ),
                            Text(
                              'ฝนตก',
                              style: TextStyle(
                                  fontFamily: 'Prompt', color: kTextColor),
                            ),
                            Text(
                                statistic
                                    .weatherStat[WeatherState.WEATHER_STATE]
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: 'Prompt', color: kTextColor))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kBoxColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'จำนวนผู้บาดเจ็บ',
                          style: TextStyle(
                              fontFamily: 'Prompt', color: Colors.white),
                        ),
                        Text(
                          statistic.totalInjured.toString(),
                          style: TextStyle(
                              fontFamily: 'Prompt', color: Colors.white),
                        ),
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kBoxColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'จำนวนผู้เสียชีวิต',
                          style: TextStyle(
                              fontFamily: 'Prompt', color: Colors.white),
                        ),
                        Text(
                          statistic.totalDead.toString(),
                          style: TextStyle(
                              fontFamily: 'Prompt', color: Colors.white),
                        ),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
