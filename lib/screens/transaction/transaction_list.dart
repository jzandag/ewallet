import 'package:ewallet_exer/model/transaction.dart';
import 'package:ewallet_exer/model/user.dart';
import 'package:ewallet_exer/model/user_data.dart';
import 'package:ewallet_exer/screens/transaction/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  int? number;

  TransactionList({this.number});

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    final UserData? userData = Provider.of<UserData?>(context);
    List<TransactionData> transactions = userData?.data ?? [];
    List<TransactionData> transactionsList = [];

    transactions.sort((b, a) => a.date!.compareTo(b.date!));
    if (widget.number! < 0) {
      transactionsList = transactions.take(5).toList();
    } else {
      transactionsList = transactions.take(widget.number!).toList();
    }

    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: transactionsList.length,
            itemBuilder: (context, index) {
              return TransactionTile(
                transaction: transactionsList[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
