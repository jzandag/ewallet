import 'package:ewallet_exer/model/user.dart';
import 'package:ewallet_exer/screens/authentication/authenticate.dart';
import 'package:ewallet_exer/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserModel?>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
