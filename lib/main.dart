import 'package:ewallet_exer/model/user.dart';
import 'package:ewallet_exer/screens/wrapper.dart';
import 'package:ewallet_exer/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Ewallet',
        theme: ThemeData(
                textTheme: GoogleFonts.openSansTextTheme(
                  Theme.of(context).textTheme,
                ),
                bottomSheetTheme:
                    BottomSheetThemeData(backgroundColor: Color(0xff78C6A3)))
            .copyWith(
          hintColor: Colors.white38,
        ),
        /*initialRoute: '/home',
          routes: {
            '/': (context) => Loading(),
            '/home': (context) => Home(),
            '/location': (context) => ChooseLocation(),
          }*/
        home: Wrapper(),
      ),
    );
  }
}
