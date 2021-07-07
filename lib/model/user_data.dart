import 'package:ewallet_exer/model/transaction.dart';

class UserData {
  final String? uid;
  List<TransactionData>? data;
  double? balance;

  UserData({this.uid = ''});

  double? get expense {
    return data!
        .where((element) => element.type! == 'expense')
        .toList()
        .fold(0, (value, element) => element.amount! + value!);
  }

  double? get income {
    return data!
        .where((element) => element.type! == 'income')
        .toList()
        .fold(0, (value, element) => element.amount! + value!);
  }
}
