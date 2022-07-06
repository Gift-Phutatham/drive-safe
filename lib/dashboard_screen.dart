import 'package:drive_safe/record_model.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'api_service.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  // instance variables
  late List<Record> records = [];
  late Map<ExpwStep, List<Record>> map = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    RecordModel _recordModel = (await ApiService().getRecord())!;

    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          records = _recordModel.result.records;
          for (var element in records) {
            if (map.containsKey(element.expwStep)) {
              map[element.expwStep]?.add(element);
            } else {
              map[element.expwStep] = [element];
            }
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "สถิติ",
          style: TextStyle(fontFamily: 'Prompt'),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: map.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemCount: map.length,
              itemBuilder: (context, index) {
                ExpwStep key = map.keys.elementAt(index);
                return Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: kBackgroundColor,
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                expwStepValues.getValue(key),
                                style: const TextStyle(fontFamily: 'Prompt'),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kBackgroundColor,
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
                                            fontFamily: 'Prompt',
                                            color: Colors.white),
                                      ),
                                      Text(
                                        '(2563 - ปัจจุบัน)',
                                        style: TextStyle(
                                            fontFamily: 'Prompt',
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    map[key]!.length.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Prompt',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  )),
    );
  }
}
