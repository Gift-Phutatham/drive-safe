import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:drive_safe/record_model.dart';
import 'package:drive_safe/statistic_model.dart';
import 'package:pie_chart/pie_chart.dart';

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
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: themeColor, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
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
                border: Border.all(color: themeColor, width: 1),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: themeColor,
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
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.sunny,
                              color: lightThemeColor,
                            ),
                            Text(
                              'ปกติ',
                              style: TextStyle(
                                  fontFamily: 'Prompt', color: lightThemeColor),
                            ),
                            Text(
                              statistic.weatherStat[WeatherState.EMPTY]
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: 'Prompt', color: lightThemeColor),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.thunderstorm,
                              color: lightThemeColor,
                            ),
                            Text(
                              'ฝนตก',
                              style: TextStyle(
                                  fontFamily: 'Prompt', color: lightThemeColor),
                            ),
                            Text(
                                statistic
                                    .weatherStat[WeatherState.WEATHER_STATE]
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: 'Prompt',
                                    color: lightThemeColor))
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
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: themeColor, width: 1),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          color: themeColor,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'จำนวนผู้บาดเจ็บ',
                            style: kTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
                        child: Text(
                          statistic.totalInjured.toString(),
                          style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: lightThemeColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: themeColor, width: 1),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          color: themeColor,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'จำนวนผู้เสียชีวิต',
                            style: kTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
                        child: Text(
                          statistic.totalDead.toString(),
                          style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: lightThemeColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: themeColor, width: 1),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: themeColor,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'สาเหตุการเกิดอุบัติเหตุ',
                        style: kTextStyle,
                      ),
                    ),
                  ),
                  Container(
                    child: PieChart(
                      dataMap: statistic.causes,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: 120,
                      legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.bottom,
                          showLegends: true,
                          legendTextStyle: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 12,
                              color: kTextColor)),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: false,
                        showChartValues: true,
                        showChartValuesInPercentage: true,
                        showChartValuesOutside: false,
                        decimalPlaces: 1,
                      ),
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
