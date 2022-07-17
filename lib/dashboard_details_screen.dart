import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'constants.dart';
import 'dashboard_details_card_header.dart';
import 'record_model.dart';
import 'statistic_model.dart';

class DashboardDetailsScreen extends StatelessWidget {
  DashboardDetailsScreen(
      {required this.name, required this.statistic, required this.themeColor});

  final String name;
  final Statistic statistic;
  final Color themeColor;
  late Color lightThemeColor = themeColor == kRedColor
      ? kLightRedColor
      : themeColor == kOrangeColor
          ? kLightOrangeColor
          : kLightYellowColor;

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
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: themeColor, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'จำนวนอุบัติเหตุทั้งหมด',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          fontSize: 16,
                          color: themeColor,
                        ),
                      ),
                      Text(
                        '(2563 - ปัจจุบัน)',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          fontSize: 16,
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeColor,
                    ),
                    child: Text(
                      statistic.totalAccidents.toString(),
                      style: const TextStyle(
                        fontSize: 28,
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
                border: Border.all(color: themeColor, width: 1),
              ),
              child: Column(
                children: <Widget>[
                  CardHeader(
                    themeColor: themeColor,
                    text: 'จำนวนอุบัติเหตุตามสภาพอากาศ',
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(
                              Icons.sunny,
                              color: lightThemeColor,
                            ),
                            Text(
                              'ปกติ',
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                color: lightThemeColor,
                              ),
                            ),
                            Text(
                              statistic.weatherStat[WeatherState.EMPTY]
                                  .toString(),
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                color: lightThemeColor,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              Icons.thunderstorm,
                              color: lightThemeColor,
                            ),
                            Text(
                              'ฝนตก',
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                color: lightThemeColor,
                              ),
                            ),
                            Text(
                              statistic.weatherStat[WeatherState.WEATHER_STATE]
                                  .toString(),
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                color: lightThemeColor,
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
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: themeColor, width: 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      CardHeader(
                          themeColor: themeColor,
                          text: 'จำนวนผู้บาดเจ็บ',
                          padding: const EdgeInsets.fromLTRB(
                              38.0, 10.0, 38.0, 10.0)),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
                        child: Text(
                          statistic.totalInjured.toString(),
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: lightThemeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: themeColor, width: 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      CardHeader(
                          themeColor: themeColor,
                          text: 'จำนวนผู้เสียชีวิต',
                          padding: const EdgeInsets.fromLTRB(
                              38.0, 10.0, 38.0, 10.0)),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
                        child: Text(
                          statistic.totalDead.toString(),
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: lightThemeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: themeColor, width: 1),
              ),
              child: Column(
                children: <Widget>[
                  CardHeader(
                      themeColor: themeColor,
                      text: 'สาเหตุการเกิดอุบัติเหตุ',
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)),
                  PieChart(
                    dataMap: statistic.causes,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: 120,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.bottom,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontFamily: 'Prompt',
                        fontSize: 12,
                        color: kTextColor,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: false,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
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
