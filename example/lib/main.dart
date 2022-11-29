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
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

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
                FlutterFormInputSwitch(
                  initialValue: true,
                  onChanged: (v) {
                    print('Switch changed to $v');
                  },
                ),
                FlutterFormInputDateTime(
                  inputType: FlutterFormDateTimeType.dateTime,
                  dateFormat: DateFormat('dd/MM/yyyy HH:mm'),
                  onChanged: (v) {
                    print('Date changed to $v');
                  },
                ),
                FlutterFormInputNumberPicker(
                  onChanged: (v) {
                    print('Number changed to $v');
                  },
                ),
                FlutterFormInputSlider(
                  onChanged: (v) {
                    print('Slider changed to $v');
                  },
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: FlutterFormInputCarousel(
                    onChanged: (v) {
                      print('Carousel changed to $v');
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
                FlutterFormInputPlainText(
                  onChanged: (v) {
                    print('Plain text changed to $v');
                  },
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: FlutterFormInputMultiLine(
                    onChanged: (v) {
                      print('Multi line changed to $v');
                    },
                  ),
                ),
                FlutterFormInputPassword(
                  onChanged: (v) {
                    print('Password changed to $v');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
