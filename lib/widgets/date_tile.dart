import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _month = DateFormat('MMM');
final _day = DateFormat('dd');

class DateTile extends StatelessWidget {
  final DateTime date;

  const DateTile({Key? key, required this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = textTheme.headline4!.color;
    return Container(
      width: 70,
      child: Column(
        children: [
          Text(
            _month.format(date),
            style: textTheme.subtitle1!.copyWith(color: color),
          ),
          SizedBox(height: 8),
          Text(
            _day.format(date),
            style: textTheme.headline5!.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
