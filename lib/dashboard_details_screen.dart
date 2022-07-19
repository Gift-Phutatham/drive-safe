import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'constants.dart';
import 'dashboard_details_card_header.dart';
import 'record_model.dart';
import 'statistic_model.dart';

class DashboardDetailsScreen extends StatelessWidget {
  DashboardDetailsScreen({
    required this.name,
    required this.statistic,
    required this.themeColor,
  });

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
        ),
        backgroundColor: kMainColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 15.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
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
                          fontSize: 18,
                          color: themeColor,
                        ),
                      ),
                      Text(
                        '(2563 - ปัจจุบัน)',
                        style: TextStyle(
                          fontSize: 17,
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: lightThemeColor,
                    ),
                    child: Text(
                      statistic.totalAccidents.toString(),
                      style: const TextStyle(
                        fontSize: 35,
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
                borderRadius: BorderRadius.circular(15),
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
                            const SizedBox(
                              height: 5,
                            ),
                            Icon(
                              Icons.sunny,
                              color: lightThemeColor,
                              size: 37,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'ปกติ',
                              style: TextStyle(
                                color: lightThemeColor,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              statistic.weatherStat[WeatherState.EMPTY]
                                  .toString(),
                              style: TextStyle(
                                color: lightThemeColor,
                                fontSize: 27,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              Icons.thunderstorm,
                              color: lightThemeColor,
                              size: 37,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'ฝนตก',
                              style: TextStyle(
                                color: lightThemeColor,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              statistic.weatherStat[WeatherState.WEATHER_STATE]
                                  .toString(),
                              style: TextStyle(
                                color: lightThemeColor,
                                fontSize: 27,
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
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: themeColor, width: 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      CardHeader(
                        themeColor: themeColor,
                        text: 'จำนวนผู้บาดเจ็บ',
                        padding:
                            const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
                        child: Text(
                          statistic.totalInjured.toString(),
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w500,
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
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: themeColor, width: 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      CardHeader(
                        themeColor: themeColor,
                        text: 'จำนวนผู้เสียชีวิต',
                        padding:
                            const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
                        child: Text(
                          statistic.totalDead.toString(),
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w500,
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
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: themeColor, width: 1),
              ),
              child: Column(
                children: <Widget>[
                  CardHeader(
                    themeColor: themeColor,
                    text: 'สาเหตุการเกิดอุบัติเหตุ',
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PieChart(
                    dataMap: statistic.causes,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 30,
                    chartRadius: 150,
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontSize: 14,
                        color: themeColor,
                        fontWeight: FontWeight.w500,
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
                  const SizedBox(
                    height: 10,
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
