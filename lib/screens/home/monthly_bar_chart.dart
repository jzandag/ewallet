import 'package:ewallet_exer/model/transaction.dart';
import 'package:ewallet_exer/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MonthlyBarChart extends StatelessWidget {
  // final List<DataSeries> data;
  //
  // MonthlyBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final UserData? userData = Provider.of<UserData?>(context);
    List<TransactionData> transactions = userData?.data ?? [];

    transactions = transactions
        .where((data) =>
            DateFormat('MMMM yyyy').format(data.date!) ==
            DateFormat('MMMM yyyy').format(DateTime.now()))
        .toList();

    double income = transactions
        .where((element) => element.type! == 'income')
        .toList()
        .fold(0, (value, element) => element.amount! + value);

    double expense = transactions
        .where((element) => element.type! == 'expense')
        .toList()
        .fold(0, (value, element) => element.amount! + value);

    List<DataSeries> data = [
      DataSeries(amount: income, type: 'income'),
      DataSeries(amount: expense, type: 'expense'),
    ];
    print(income);
    List<charts.Series<DataSeries, String>> series = [
      charts.Series(
        id: "Data",
        data: data,
        domainFn: (DataSeries series, _) => series.type,
        measureFn: (DataSeries series, _) => series.amount,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
          Color(0xff036666),
        ),
      ),
    ];
    return Container(
      height: 100,
      width: 300,
      child: charts.BarChart(
        series,
        animate: true,
      ),
    );
  }
}

class DataSeries {
  final double amount;
  final String type;

  DataSeries({required this.amount, required this.type});
}
