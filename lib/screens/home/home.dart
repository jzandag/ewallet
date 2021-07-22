import 'package:ewallet_exer/model/transaction.dart';
import 'package:ewallet_exer/model/user.dart';
import 'package:ewallet_exer/model/user_data.dart';
import 'package:ewallet_exer/screens/home/chart_content.dart';
import 'package:ewallet_exer/screens/home/home_content.dart';
import 'package:ewallet_exer/screens/transaction/transaction_list.dart';
import 'package:ewallet_exer/screens/transaction/transactions_page.dart';
import 'package:ewallet_exer/services/auth.dart';
import 'package:ewallet_exer/shared/transaction_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:ewallet_exer/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserModel?>(context);

    return StreamProvider<UserData?>.value(
      initialData: null,
      value: DatabaseService(uid: user!.uid).transactions,
      builder: (context, _) => Scaffold(
        backgroundColor: Color(0xff99E2B4),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Logout button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () async {
                      await _authService.signOut();
                    },
                    child: Text('LOGOUT'),
                  ),
                ],
              ),
              //Current Balance
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text('Current balance'),
                      ),
                      //Amount
                      HomeContent(),
                      //bar graph
                      ChartContent(),
                      //latest transactions
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                        child: Text(
                          'Latest Transactions',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TransactionList(
                        number: -1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ElevatedButton.icon(
                                label: Text('See more'),
                                icon: Icon(Icons.arrow_right_alt),
                                onPressed: () => {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TransactionProvider(
                                        child: TransactionsPage(),
                                        uid: user.uid,
                                      ),
                                    ),
                                  )
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff358F80),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
