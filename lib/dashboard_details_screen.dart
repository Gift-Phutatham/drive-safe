import 'package:flutter/material.dart';

import 'constants.dart';
import 'record_model.dart';
import 'statistic_model.dart';

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
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: kTextColor,
                        ),
                      ),
                      Text(
                        '(2563 - ปัจจุบัน)',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: kTextColor,
                        ),
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: kBoxColor,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'จำนวนอุบัติเหตุตามสภาพอากาศ',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.sunny,
                              color: kTextColor,
                            ),
                            const Text(
                              'ปกติ',
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                color: kTextColor,
                              ),
                            ),
                            Text(
                              statistic.weatherStat[WeatherState.EMPTY]
                                  .toString(),
                              style: const TextStyle(
                                fontFamily: 'Prompt',
                                color: kTextColor,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.thunderstorm,
                              color: kTextColor,
                            ),
                            const Text(
                              'ฝนตก',
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                color: kTextColor,
                              ),
                            ),
                            Text(
                              statistic.weatherStat[WeatherState.WEATHER_STATE]
                                  .toString(),
                              style: const TextStyle(
                                fontFamily: 'Prompt',
                                color: kTextColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
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
                      const Text(
                        'จำนวนผู้บาดเจ็บ',
                        style: kTextStyle,
                      ),
                      Text(
                        statistic.totalInjured.toString(),
                        style: kTextStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
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
                      const Text(
                        'จำนวนผู้เสียชีวิต',
                        style: kTextStyle,
                      ),
                      Text(
                        statistic.totalDead.toString(),
                        style: kTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
