import 'package:ewallet_exer/model/transaction.dart';
import 'package:ewallet_exer/model/user.dart';
import 'package:ewallet_exer/model/user_data.dart';
import 'package:ewallet_exer/services/database.dart';
import 'package:ewallet_exer/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> types = ['expense', 'income'];

  // form values
  String? _currentDescription;
  String? _currentType = 'expense';
  double? _currentAmount;
  String _error = '';
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {

    final UserModel? user = Provider.of<UserModel?>(context);

    final UserData? userData = Provider.of<UserData?>(context);
    List<TransactionData> transactions = userData!.data ?? [];

    final DatabaseService _databaseService =
        DatabaseService(uid: user!.uid, balance: userData.balance);

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _currentDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != _currentDate)
        setState(() {
          _currentDate = picked;
        });
    }

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Add new record',
              style: TextStyle(fontSize: 18.0),
            ),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                hintText: 'Description...',
                hintStyle: TextStyle(color: Colors.black38),
              ),
              validator: (val) =>
                  val!.isEmpty ? 'Please enter description' : null,
              onChanged: (val) => setState(() => _currentDescription = val),
            ),
            DropdownButtonFormField(
              value: _currentType,
              items: types.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(
                      '${type.substring(0, 1).toUpperCase()}${type.substring(1)}'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentType = val as String?),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: textInputDecoration.copyWith(
                hintText: 'Amount...',
                hintStyle: TextStyle(color: Colors.black38),
              ),
              validator: (val) => val!.isEmpty ? 'Please enter amount' : null,
              onChanged: (val) =>
                  setState(() => _currentAmount = double.parse(val)),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("${_currentDate.toLocal()}".split(' ')[0]),
                  SizedBox(
                    width: 20.0,
                  ),
                  RaisedButton(
                    color: Color(0xff577590),
                    onPressed: () => _selectDate(context),
                    child: Text('Select date'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              color: Color(0xff036666),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final transaction = TransactionData(
                      description: _currentDescription,
                      amount: _currentAmount,
                      date: _currentDate,
                      type: _currentType);
                  if (_currentType == 'expense' &&
                      _currentAmount! > userData.balance!) {
                    setState(() {
                      _error =
                          'Cannot record expense greater than current balance';
                    });
                  } else {
                    _databaseService.saveTransaction(transaction);
                    Navigator.pop(context);
                  }
                }
              },
            ),
            _error != ''
                ? Center(
                    child: Text(
                      _error,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: Colors.redAccent),
                    ),
                  )
                : Container(
                    child: Text(_error),
                  ),
          ],
        ),
      ),
    );
  }
}
