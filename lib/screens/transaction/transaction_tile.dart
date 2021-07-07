import 'package:ewallet_exer/model/transaction.dart';
import 'package:ewallet_exer/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final TransactionData? transaction;
  final numFormat = new NumberFormat("#,##0.0", "en_US");

  TransactionTile({this.transaction});

  final incomeIcon = Icon(
    Icons.auto_awesome,
    color: Colors.greenAccent,
  );
  final expenseIcon = Icon(
    Icons.flash_on_rounded,
    color: Colors.redAccent,
  );

  @override
  Widget build(BuildContext context) {
    bool isExpense = transaction!.type == 'expense';

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isExpense ? expenseIcon : incomeIcon,
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isExpense ? 'Expense' : 'Income',
                        style: textStyle,
                      ),
                      Text(
                        '${transaction!.description}',
                        style: textStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Text(
              '₱ ${numFormat.format(transaction!.amount)}',
              style: isExpense ? expenseStyle : incomeStyle,
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xff036666),
        boxShadow: [
          BoxShadow(color: Color(0xff036666), spreadRadius: 3),
        ],
      ),
    );
  }
}
