import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet_exer/model/transaction.dart';
import 'package:ewallet_exer/model/user.dart';
import 'package:ewallet_exer/model/user_data.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String? uid;
  double? balance;
  DatabaseService({this.uid, this.balance});

  //collection reference
  final CollectionReference transactionCollection =
      Firestore.instance.collection('transaction');

  // initialize collection per user
  Future initializeUserData() async {
    return await transactionCollection
        .document(uid)
        .setData({'transactions': [], 'balance': '0'});
  }

  // transaction data from snapshot
  UserData? _transactionDataFromSnapshot(DocumentSnapshot snapshot) {
    UserData user = UserData(
      uid: uid,
    );

    user.balance = double.parse(snapshot.data['balance']);
    balance = double.parse(snapshot.data['balance']);
    user.data = snapshot.data['transactions'].map<TransactionData>((doc) {
      return TransactionData(
          date: DateTime.parse(doc['date']),
          amount: double.parse(doc['amount'] ?? 0.0),
          type: doc['type'] ?? '',
          description: doc['description'] ?? '');
    }).toList();

    return user;
  }

  // get transactions stream
  Stream<UserData?> get transactions {
    return transactionCollection
        .document(uid)
        .snapshots()
        .map(_transactionDataFromSnapshot);
  }

  // save transaction
  Future saveTransaction(TransactionData data) async {
    return await transactionCollection.document(uid).updateData({
      "transactions": FieldValue.arrayUnion([
        {
          "amount": data.amount.toString(),
          "description": data.description,
          "date": DateFormat('yyyy-MM-dd').format(data.date!),
          "type": data.type
        }
      ]),
      "balance": (balance! + (data.amount! * (data.type == 'income' ? 1 : -1)))
          .toString()
    });
  }
}
