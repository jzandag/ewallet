import 'package:ewallet_exer/screens/home/monthly_bar_chart.dart';
import 'package:flutter/material.dart';

class ChartContent extends StatefulWidget {
  const ChartContent({Key? key}) : super(key: key);

  @override
  _ChartContentState createState() => _ChartContentState();
}

class _ChartContentState extends State<ChartContent> {
  final List<String> types = ['expense', 'income'];

  String chartType = "monthly";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            child: Text(
              'This month\'s statistics',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          Center(
            child: MonthlyBarChart(),
          ),
        ],
      ),
    );
  }
}
