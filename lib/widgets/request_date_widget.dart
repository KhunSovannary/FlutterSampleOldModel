import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
//
//class RequestDateWidget extends StatefulWidget {
//
//  RequestDateWidget({@required this.title});
//
//  final String title;
//
//  @override
//  _RequestDateWidgetState createState() => _RequestDateWidgetState();
//}
//
//class _RequestDateWidgetState extends State<RequestDateWidget> {
//  TextEditingController _controller1;
//  TextEditingController _controller4;
//
//  final DateTime now = DateTime.now();
//  final DateFormat formatter = DateFormat('yyyy-MM-dd');
//  //String _initialValue;
//  String _valueTime = DateTime.now().toString().split(' ')[1].split('.')[0];
//  String _valueDate = DateTime.now().toIso8601String().split('T')[0];
//
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      child: Padding(
//        padding: const EdgeInsets.all(10),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: [
//            Text(widget.title, style: TextStyle(
//                fontSize: 20,
//                fontWeight: FontWeight.bold,
//                color: Colors.black54
//              ),
//            ),
//            SizedBox(height: 10,),
//            Row(
//              children: [
//                Icon(Icons.calendar_today, color: Colors.orange,),
//                SizedBox(width: 8),
//                Text('Date/Time', style: TextStyle(
//                  fontSize: 17, color: Colors.black54
//                ),)
//              ],
//            ),
//            SizedBox(height: 10),
//            DateTimePicker(
//              type: DateTimePickerType.date,
//              dateMask: 'd MMM, yyyy',
//              controller: _controller1,
//              decoration: new InputDecoration(
//                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                  focusedBorder: OutlineInputBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                    borderSide: BorderSide(color: Colors.grey)),
//                  border: new OutlineInputBorder(
//                      borderSide: new BorderSide(color: Colors.teal)),
//              ),
//              initialValue: _valueDate,
//              firstDate: DateTime(2000),
//              lastDate: DateTime(2100),
//              timeLabelText: "Hour",
//              selectableDayPredicate: (date) {
//                if (date.weekday == 6 || date.weekday == 7) {
//                  return false;
//                }
//                return true;
//              },
//              onChanged: (val) => {
//                setState(() => _valueDate = val)
//              },
//              validator: (val) {
//                setState(() => _valueDate = val);
//                return null;
//              },
//              onSaved: (val) => {
//                setState(() => _valueDate = val)
//              },
//            ),
//            SizedBox(height: 10),
//            DateTimePicker(
//              type: DateTimePickerType.time,
//              controller: _controller4,
//              initialValue: _valueTime,
//              use24HourFormat: false,
//              //locale: Locale('en', 'US'),
//              decoration: new InputDecoration(
//                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                focusedBorder: OutlineInputBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                    borderSide: BorderSide(color: Colors.grey)),
//                border: new OutlineInputBorder(
//                    borderSide: new BorderSide(color: Colors.teal)),
//              ),
//              onChanged: (val) => {
//                print('changed : $val'),
//                setState(() => _valueTime = val)
//              },
//              validator: (val) {
//                setState(() => _valueTime = val);
//                return null;
//              },
//              onSaved: (val) => setState(() => _valueTime = val),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

class RequestDateWidget extends StatelessWidget {

  RequestDateWidget({
    @required this.title,
    @required this.initValueDate,
    @required this.initValueTime,
    @required this.textControllerDate,
    @required this.textControllerTime,
    @required this.functionDate,
    @required this.functionTime,
  });

  final String title;
  final dynamic initValueDate, initValueTime;
  final TextEditingController textControllerDate, textControllerTime;
  final Function functionDate, functionTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.orange,),
                SizedBox(width: 8),
                Text('Date/Time', style: TextStyle(
                  fontSize: 17, color: Colors.black54
                ),)
              ],
            ),
            SizedBox(height: 10),
            DateTimePicker(
              type: DateTimePickerType.date,
              dateMask: 'd MMM, yyyy',
              controller: textControllerDate,
              decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
              ),
              initialValue: initValueDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              timeLabelText: "Hour",
//              selectableDayPredicate: (date) {
//                if (date.weekday == 6 || date.weekday == 7) {
//                  return false;
//                }
//                return true;
//              },
              onChanged: functionDate,
              validator: functionDate,
              onSaved: functionDate,
            ),
            SizedBox(height: 10),
            DateTimePicker(
              type: DateTimePickerType.time,
              controller: textControllerTime,
              initialValue: initValueTime,
              use24HourFormat: false,
              //locale: Locale('en', 'US'),
              decoration: new InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
              ),
              onChanged: functionTime,
              validator: functionTime,
              onSaved: functionTime,
            ),
          ],
        ),
      ),
    );
  }
}

