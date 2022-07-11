import 'dart:convert';

RecordModel recordModelFromJson(String str) =>
    RecordModel.fromJson(json.decode(str));

String recordModelToJson(RecordModel data) => json.encode(data.toJson());

class RecordModel {
  RecordModel({
    required this.help,
    required this.success,
    required this.result,
  });

  String help;
  bool success;
  Result result;

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        help: json["help"],
        success: json["success"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "help": help,
        "success": success,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    required this.includeTotal,
    required this.resourceId,
    required this.fields,
    required this.recordsFormat,
    required this.records,
    required this.links,
    required this.total,
  });

  bool includeTotal;
  String resourceId;
  List<Field> fields;
  String recordsFormat;
  List<Record> records;
  Links links;
  int total;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        includeTotal: json["include_total"],
        resourceId: json["resource_id"],
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
        recordsFormat: json["records_format"],
        records:
            List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
        links: Links.fromJson(json["_links"]),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "include_total": includeTotal,
        "resource_id": resourceId,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "records_format": recordsFormat,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "_links": links.toJson(),
        "total": total,
      };
}

class Field {
  Field({
    required this.type,
    required this.id,
  });

  String type;
  String id;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
      };
}

class Links {
  Links({
    required this.start,
    required this.next,
  });

  String start;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        start: json["start"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "start": start,
        "next": next,
      };
}

class Record {
  Record({
    required this.id,
    required this.accidentDate,
    required this.accidentTime,
    required this.expwStep,
    required this.weatherState,
    required this.injurMan,
    required this.injurFemel,
    required this.deadMan,
    required this.deadFemel,
    required this.cause,
  });

  int id;
  DateTime accidentDate;
  String accidentTime;
  ExpwStep expwStep;
  WeatherState weatherState;
  int injurMan;
  int injurFemel;
  int deadMan;
  int deadFemel;
  String cause;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["_id"],
        accidentDate: DateTime.parse(json["accident_date"]),
        accidentTime: json["accident_time"],
        expwStep: expwStepValues.map[json["expw_step"]]!,
        weatherState: weatherStateValues.map[json["weather_state"]]!,
        injurMan: json["injur_man"],
        injurFemel: json["injur_femel"],
        deadMan: json["dead_man"],
        deadFemel: json["dead_femel"],
        cause: json["cause"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "accident_date": accidentDate.toIso8601String(),
        "accident_time": accidentTime,
        "expw_step": expwStepValues.reverse[expwStep],
        "weather_state": weatherStateValues.reverse[weatherState],
        "injur_man": injurMan,
        "injur_femel": injurFemel,
        "dead_man": deadMan,
        "dead_femel": deadFemel,
        "cause": cause,
      };
}

enum ExpwStep {
  EMPTY,
  EXPW_STEP,
  THE_37,
  PURPLE,
  FLUFFY,
  TENTACLED,
  STICKY,
  S1,
  A
}

final expwStepValues = EnumValues({
  "ศรีรัช": ExpwStep.EMPTY,
  "บางพลี-สุขสวัสดิ์": ExpwStep.EXPW_STEP,
  "ฉลองรัช": ExpwStep.FLUFFY,
  "บูรพาวิถี": ExpwStep.PURPLE,
  "S1": ExpwStep.S1,
  "อุดรรัถยา": ExpwStep.STICKY,
  "เฉลิมมหานคร": ExpwStep.TENTACLED,
  "ทางหลวงพิเศษหมายเลข 37": ExpwStep.THE_37,
  "ศรีรัช-วงแหวนรอบนอก": ExpwStep.A
});

enum WeatherState { EMPTY, WEATHER_STATE }

final weatherStateValues = EnumValues(
    {"ปกติ": WeatherState.EMPTY, "ฝนตก": WeatherState.WEATHER_STATE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  String getValue(T key) {
    if (reverse.containsKey(key)) {
      return reverse[key]!;
    } else {
      return "";
    }
  }

  Map<T, String> get reverse {
    if (reverseMap.isEmpty) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
