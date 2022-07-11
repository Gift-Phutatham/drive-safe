import 'package:drive_safe/record_model.dart';

class Statistic {
  Statistic({
    required this.totalAccidents,
    required this.weatherStat,
    required this.totalDead,
    required this.totalInjured,
  });

  int totalAccidents;
  Map<WeatherState, int> weatherStat;
  int totalDead;
  int totalInjured;
// Map<String, int> causes;
}
