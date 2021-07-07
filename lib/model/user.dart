import 'package:ewallet_exer/model/transaction.dart';

class UserModel {
  final String? uid;
  List<TransactionData>? data;
  double? balance;

  UserModel({this.uid = ''});
}
