import 'package:flutter/material.dart';
import 'package:ewallet_exer/test/Quote.dart';

class QuoteCard extends StatelessWidget {

  Quote quote;
  Function delete;

  QuoteCard({required this.quote, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                quote.text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                quote.author,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[400],
                ),
              ),
              FlatButton.icon(
                onPressed: (){delete();},
                label: Text('delete quote'),
                icon: Icon(Icons.delete),
              )
            ],
          ),
        )
    );;
  }
}
