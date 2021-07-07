import 'package:ewallet_exer/model/transaction.dart';
import 'package:ewallet_exer/model/user.dart';
import 'package:ewallet_exer/model/user_data.dart';
import 'package:ewallet_exer/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionProvider extends StatelessWidget {
  final child;
  final uid;

  TransactionProvider({this.child, this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData?>.value(
      initialData: null,
      value: DatabaseService(uid: uid).transactions,
      builder: (context, _) => child,
    );
  }
}
