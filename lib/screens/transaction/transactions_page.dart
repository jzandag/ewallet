import 'package:ewallet_exer/model/user.dart';
import 'package:ewallet_exer/screens/transaction/transaction_form.dart';
import 'package:ewallet_exer/screens/transaction/transaction_list.dart';
import 'package:ewallet_exer/shared/constants.dart';
import 'package:ewallet_exer/shared/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  int _itemCount = 5;
  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserModel?>(context);

    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: TransactionProvider(
              child: TransactionForm(),
              uid: user!.uid,
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Color(0xff358F80),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                elevation: 2.0,
                fillColor: Color(0xff036666),
                child: Icon(
                  Icons.west,
                  size: 20,
                  color: Colors.white54,
                ),
                padding: EdgeInsets.all(8),
                shape: CircleBorder(),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                constraints: BoxConstraints(minWidth: 0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRANSACTIONS',
                    style: textStyle.copyWith(fontSize: 28),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'All transactions',
                          style: textStyle.copyWith(color: Colors.white70),
                        ),
                      ),
                      Container(
                        child: RawMaterialButton(
                          onPressed: () {
                            _showSettingsPanel();
                          },
                          elevation: 2.0,
                          fillColor: Color(0xff036666),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white54,
                          ),
                          padding: EdgeInsets.all(8),
                          shape: CircleBorder(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          constraints: BoxConstraints(minWidth: 0),
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff14746F).withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 10), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    TransactionList(
                      number: _itemCount,
                    ),
                    ElevatedButton(
                      child: Text(
                        'SEE MORE',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      onPressed: () {
                        setState(() {
                          _itemCount += 5;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff99E2B4),
                        side: BorderSide(width: 1.5, color: Colors.black),
                      ),
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Color(0xff99E2B4),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
