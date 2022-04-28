
import 'package:events/models/event.dart';
import 'package:flutter/material.dart';

class BottomSheetContent extends StatefulWidget {
  final Function addEvent;
  const BottomSheetContent({Key? key, required this.addEvent})
      : super(key: key);

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final _controller = TextEditingController();
  DateTime? date;
  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2023))
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          date = value;
                        });
                      }
                    });
                  },
                  child: const Text("pick date")),
              if (date != null)
                Text("${date!.year}-${date!.month}-${date!.day}"),
              OutlinedButton(
                  onPressed: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          time = value;
                        });
                      }
                    });
                  },
                  child: const Text("pick time")),
              if (time != null) Text("${time!.hour}:${time!.minute}"),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                  onPressed: () {
                    if (date == null ||
                        time == null ||
                        _controller.text.isEmpty) {
                      return;
                    }
                    final res = DateTime(date!.year, date!.month, date!.day,
                        time!.hour, time!.minute);
                      widget
                          .addEvent(Event(title: _controller.text, time: res));
                    Navigator.of(context).pop();
                  },
                  child: const Text("save"))
            ],
          )
        ],
      ),
    );
  }
}
