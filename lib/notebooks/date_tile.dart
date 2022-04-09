import 'package:flutter/material.dart';

class DateTile extends StatelessWidget {
  final String month;
  final String day;
  const DateTile({Key? key, required this.month, required this.day})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Column(
        children: [
          Text(month),
          Text(day, style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }
}
