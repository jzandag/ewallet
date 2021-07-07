import 'package:ewallet_exer/model/transaction.dart';
import 'package:ewallet_exer/model/user_data.dart';
import 'package:ewallet_exer/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatelessWidget {
  final numFormat = NumberFormat("#,##0.0", "en_US");

  @override
  Widget build(BuildContext context) {
    final UserData? userData = Provider.of<UserData?>(context);
    List<TransactionData> transactions = userData?.data ?? [];

    double? income = userData?.income;
    double? expense = userData?.expense;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  '₱',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  numFormat.format(userData?.balance ?? 0),
                  style: TextStyle(fontSize: 50),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 45), child: Text('PHP')),
            ],
          ),
        ),
        // total expense and income
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //income
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Icon(
                                Icons.add_reaction,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              child: Text(
                                '₱ ${numFormat.format(income ?? 0)}',
                                style: textStyle.copyWith(fontSize: 23),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                            Text(
                              'your income',
                              style: TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                        margin: EdgeInsets.fromLTRB(15, 10, 15, 20),
                      ),
                      //expense
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Icon(
                                Icons.sick,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              child: Text(
                                '₱ ${numFormat.format(expense ?? 0)}',
                                style: textStyle.copyWith(fontSize: 23),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                            Text(
                              'your expense',
                              style: TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                        margin: EdgeInsets.fromLTRB(15, 10, 0, 20),
                      ),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                color: Color(0xff036666),
                boxShadow: [
                  BoxShadow(color: Color(0xff036666), spreadRadius: 3),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
