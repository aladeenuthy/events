import 'dart:async';

import 'package:flutter/material.dart';

class ViewEvent extends StatefulWidget {
  final String title;
  final DateTime date;
  const ViewEvent({Key? key, required this.title, required this.date})
      : super(key: key);

  @override
  _ViewEventState createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  Duration? duration;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    final res = widget.date.difference(DateTime.now()).inSeconds;
    duration = Duration(seconds: res);
    startTimer();
    
  }

  void decrement() {
      if (duration!.inSeconds <= 0) {
        timer!.cancel();
      } else {
        final dec = duration!.inSeconds - 1;
        setState(() {
          duration = Duration(seconds: dec);
        });
      }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      decrement();
    });
  }

  Widget _buildTimeBrick(num time, String label) {
    String twoDigits(num m) => m.toString().padLeft(2, "0");
    final res = twoDigits(time);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(res),
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(height: 20),
          Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            _buildTimeBrick(duration!.inDays, "days"),
            const SizedBox(width: 5,),
            _buildTimeBrick(duration!.inHours.remainder(24), "hrs"),
              const SizedBox(
                width: 5,
              ),
              _buildTimeBrick(duration!.inMinutes.remainder(60), "min"),
              const SizedBox(
                width: 5,
              ),
              _buildTimeBrick(duration!.inSeconds.remainder(60), "secs"),
              
          ],))
        ],
      ),
    );
  }
}
