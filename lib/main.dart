import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() {
  runApp(const PickerClip());
}

class PickerClip extends StatelessWidget {
  const PickerClip({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClipDateRangePicker(),
    );
  }
}

class ClipDateRangePicker extends StatefulWidget {
  const ClipDateRangePicker({Key? key}) : super(key: key);
  @override
  _ClipDateRangePickerState createState() => _ClipDateRangePickerState();
}

class _ClipDateRangePickerState extends State<ClipDateRangePicker> {
  double weeksInMonth = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker Demo'),
      ),
      body:
      ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 1 - (6 - weeksInMonth) / 7,
          child: Container(
            height: 200,
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              onViewChanged: (DateRangePickerViewChangedArgs args) {
                if (args.visibleDateRange.startDate!.weekday >=
                    DateTime.friday &&
                    (args.visibleDateRange.endDate!.weekday ==
                        DateTime.sunday ||
                        args.visibleDateRange.endDate!.weekday ==
                            DateTime.monday)) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      weeksInMonth = 6;
                    });
                  });
                } else if (weeksInMonth == 6) {
                  weeksInMonth = 5;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}