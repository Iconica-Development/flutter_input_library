import 'package:flutter/material.dart';
import 'package:flutter_input_library/flutter_input_library.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var weekDayDateFormat = DateFormat('EEEE');
  var monthDateFormat = DateFormat('MMMM');

  var formKey = GlobalKey<FormState>();

  var weekDays = TypeUtils().createWeekDays(WeekDay.monday, WeekDay.sunday);
  var dates = TypeUtils().createMonthList(Month.january, Month.december, 2023);
  var years = TypeUtils().createYearList(2000, 2023);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(height: 10),
                const Text('FlutterFormInputSwitch'),
                FlutterFormInputSwitch(
                  initialValue: true,
                  onChanged: (v) {
                    debugPrint('Switch changed to $v');
                  },
                ),
                Container(height: 50),
                const Text('FlutterFormInputDateTime'),
                FlutterFormInputDateTime(
                  timePickerEntryMode: TimePickerEntryMode.dialOnly,
                  style: const TextStyle(color: Colors.red),
                  decoration: const InputDecoration(label: Text('test')),
                  inputType: FlutterFormDateTimeType.time,
                  dateFormat: DateFormat('HH:mm'),
                  onChanged: (v) {
                    debugPrint('Date changed to $v');
                  },
                ),
                Container(height: 50),
                const Text('FlutterFormInputNumberPicker'),
                FlutterFormInputNumberPicker(
                  onChanged: (v) {
                    debugPrint('Number changed to $v');
                  },
                ),
                Container(height: 50),
                const Text('FlutterFormInputSlider'),
                FlutterFormInputSlider(
                  onChanged: (v) {
                    debugPrint('Slider changed to $v');
                  },
                ),
                Container(height: 50),
                const Text('FlutterFormInputCarousel'),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: FlutterFormInputCarousel(
                    onChanged: (v) {
                      debugPrint('Carousel changed to $v');
                    },
                    items: [
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.green,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                Container(height: 50),
                const Text('FlutterFormInputPlainText'),
                FlutterFormInputPlainText(
                  onChanged: (v) {
                    debugPrint('Plain text changed to $v');
                  },
                ),
                Container(height: 50),
                const Text('FlutterFormInputMultiLine'),
                SizedBox(
                  height: 200,
                  width: 300,
                  child: FlutterFormInputMultiLine(
                    onChanged: (v) {
                      debugPrint('Multi line changed to $v');
                    },
                  ),
                ),
                Container(height: 50),
                const Text('FlutterFormInputPassword'),
                FlutterFormInputPassword(
                  onChanged: (v) {
                    debugPrint('Password changed to $v');
                  },
                ),
                Container(height: 50),
                const Text('FlutterFormInputScrollPicker: Weekdays'),
                const SizedBox(
                  height: 8,
                ),
                FlutterFormInputScrollPicker(
                  values: weekDays,
                  onChanged: (value) {},
                  childToString: (s) =>
                      s != null ? weekDayDateFormat.format(s) : '',
                  decoration: const ScrollPickerDecoration(),
                ),
                const Text('FlutterFormInputScrollPicker: Months'),
                const SizedBox(
                  height: 8,
                ),
                FlutterFormInputScrollPicker(
                  values: dates,
                  onChanged: (value) {},
                  childToString: (s) =>
                      s != null ? monthDateFormat.format(s) : '',
                  decoration: const ScrollPickerDecoration(),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                const Text('FlutterFormInputScrollPicker: Years'),
                const SizedBox(
                  height: 8,
                ),
                FlutterFormInputScrollPicker(
                  values: years,
                  onChanged: (value) {},
                  childToString: (s) => s?.year.toString() ?? '',
                  decoration: const ScrollPickerDecoration(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
