import 'package:flutter/material.dart';
import 'package:ewallet_exer/test/Quote.dart';
import 'package:ewallet_exer/test/QuoteCard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Quote> quotes = [
    Quote(author: 'Oscar Wilde', text: 'Be yourself; everyone else is already taken'),
    Quote(author: 'Oscar Wilde', text: 'I have nothing to declare except my genius'),
    Quote(author: 'Oscar Wilde', text: 'The truth is rarely pure and never simple')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My firstApp'),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: Column(
        children: quotes.map((e) => QuoteCard(
            quote: e,
            delete: () {
              setState(() {
                quotes.remove(e);
              });
            })).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('click'),
        onPressed: () {
        },
      ),
    );
  }
}
